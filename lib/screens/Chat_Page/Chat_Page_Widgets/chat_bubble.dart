import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChatBubble extends StatelessWidget {
  final bool isContinuous;
  final Map<String, String> cacheMap;
  final QueryDocumentSnapshot messageData;
  final Color color;
  const ChatBubble(
      {Key key, this.messageData, this.isContinuous, this.cacheMap, this.color})
      : super(key: key);

  FutureBuilder func(String userId) {
    DocumentReference referenceImage = messageData['imageReference'];
    return FutureBuilder(
      future: referenceImage.get(),
      initialData: {
        'imageUrl': 'none',
        'text': 'messageText',
        'userId': "none",
        'isAdmin': false,
        'userName': 'Amalgam Team'
      },
      builder: (ctx, snap) {
        if (snap.data == null) {
          return CircleAvatar(
            child: Icon(Icons.person_sharp),
          );
        }
        if (snap.data['userName'] == 'Amalgam Team') {
          print('object');
          return CircleAvatar(backgroundImage: AssetImage('amalgam_logo.png'));
        }
        final url = snap.data['imageUrl'];
        cacheMap.putIfAbsent(userId, () => url);

        return url == "none"
            ? (snap.data['userId'] == 'spec_message_for_welcome')
                ? CircleAvatar(
                    backgroundImage: AssetImage('assets/amalgam_logo.png'))
                : CircleAvatar(
                    child: Icon(Icons.person_sharp),
                  )
            : CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                  url,
                ),
              );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // final isUser = messageData['userId'] == userIdGlobal;
    final String messageText = messageData['text'];
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    final String time = DateFormat.jm().format(messageData['time'].toDate());
    return Padding(
      padding: (isContinuous)
          ? EdgeInsets.all(0)
          : EdgeInsets.only(top: 8.0, left: 8),
      child: Row(
        children: [
          Container(
            constraints: BoxConstraints(
              minWidth: 50,
              maxWidth: width / 1.1,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (isContinuous)
                    ? Container(height: 0, width: 50)
                    : cacheMap.containsKey(messageData['userId'])
                        ? CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                              cacheMap[messageData["userId"]],
                            ),
                          )
                        : func(messageData['userId']),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isContinuous)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.ideographic,
                          children: [
                            Text(
                              messageData['userName'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: color.withAlpha(150),
                              ),
                            ),
                            if (messageData.data().containsKey('isAdmin') &&
                                messageData['isAdmin'])
                              Text("  Admin",
                                  style: GoogleFonts.lato(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber)),
                            SizedBox(
                              width: 5,
                            ),
                            Text(time,
                                textAlign: TextAlign.right,
                                style: TextStyle(fontSize: 10))
                          ],
                        ),
                      InkWell(
                        onLongPress: () {
                          Clipboard.setData(
                              new ClipboardData(text: messageText));
                          Fluttertoast.showToast(
                              msg: "Text Message Copied",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        },
                        child: Container(
                          constraints: BoxConstraints(
                            minWidth: 50,
                            maxWidth: width / 1.4,
                          ),
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  messageText,
                                  style: GoogleFonts.lato(
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
