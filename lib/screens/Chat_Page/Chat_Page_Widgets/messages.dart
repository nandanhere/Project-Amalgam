import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_amalgam/Common_widgets/CustomCircularProgressIndicator.dart';

import '../../../globals.dart';
import 'chat_bubble.dart';

class Messages extends StatelessWidget {
  final String projectId;
  const Messages({
    Key key,
    @required this.projectId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, String> cacheMap = new Map();
    // String prevMessageid = "";
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('projects')
          .doc(projectId)
          .collection('chat')
          .orderBy('time', descending: true)
          .snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CustomProgressIndicator(),
          );
        }

        final chatDoc = snapshot.data.documents;
        getColors(String uid) async {
          final doc = await FirebaseFirestore.instance
              .collection('projects')
              .doc(projectId)
              .collection('userData')
              .doc(uid)
              .get();
          return doc["color"];
        }

        return Center(
          child: ListView.builder(
              reverse: true,
              itemCount: chatDoc.length,
              itemBuilder: (ctx, index) {
                bool isContinuous = false;
                if (index != 0 && index + 1 < chatDoc.length) {
                  isContinuous =
                      chatDoc[index + 1]['userId'] == chatDoc[index]['userId'];
                }
                return FutureBuilder(
                  future: getColors(chatDoc[index]['userId']),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Container(
                            margin: index == chatDoc.length - 1 || index == 0
                                ? (index == 0)
                                    ? EdgeInsets.only(bottom: 10)
                                    : EdgeInsets.only(top: 20)
                                : null,
                            child: ChatBubble(
                                cacheMap: cacheMap,
                                color: colorList[snapshot.data],
                                isContinuous: isContinuous,
                                messageData: chatDoc[index],
                                key: ValueKey(chatDoc[index].documentID)));
                      } else {
                        return Container(
                            margin: index == chatDoc.length - 1 || index == 0
                                ? (index == 0)
                                    ? EdgeInsets.only(bottom: 10)
                                    : EdgeInsets.only(top: 20)
                                : null,
                            child: ChatBubble(
                                cacheMap: cacheMap,
                                color: Colors.blue,
                                isContinuous: isContinuous,
                                messageData: chatDoc[index],
                                key: ValueKey(chatDoc[index].documentID)));
                      }
                    } else {
                      return Container(
                          margin: index == chatDoc.length - 1 || index == 0
                              ? (index == 0)
                                  ? EdgeInsets.only(bottom: 10)
                                  : EdgeInsets.only(top: 20)
                              : null,
                          child: ChatBubble(
                              cacheMap: cacheMap,
                              color: Colors.blue,
                              isContinuous: isContinuous,
                              messageData: chatDoc[index],
                              key: ValueKey(chatDoc[index].documentID)));
                    }
                  },
                );
              }),
        );
      },
    );
  }
}
