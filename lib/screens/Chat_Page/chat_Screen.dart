import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_amalgam/Common_widgets/CustomCircularProgressIndicator.dart';
import 'package:project_amalgam/screens/Modal_Page/ModalPage.dart';
import 'package:project_amalgam/screens/Shared_Button_Screen/SharedButtonScreen.dart';

import '../../globals.dart';
import 'Chat_Page_Widgets/messages.dart';
import 'Chat_Page_Widgets/new_message.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = '/Chat';
  const ChatScreen({
    Key key,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isAdmin;
  String projectId;
  String projectName;
  DocumentSnapshot userDataInGroup;

  @override
  void initState() {
    super.initState();
  }

  Future<void> getProjectDetails() async {
    print(userIdGlobal);
    print(projectId);
    final DocumentSnapshot data = await FirebaseFirestore.instance
        .collection('projects')
        .doc(projectId)
        .collection('userData')
        .doc(userIdGlobal)
        .get();
    userDataInGroup = data;
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String> args = ModalRoute.of(context).settings.arguments;
    projectId = args['projectId'];
    projectName = args['projectName'];
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('projects')
            .doc(projectId)
            .collection('userData')
            .doc(userIdGlobal)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              backgroundColor: darkMode(),
              body: Center(
                child: CustomProgressIndicator(),
              ),
            );
          }
          final snapdata = snapshot.data;
          print(snapdata['isAdmin']);
          isAdmin = snapdata['isAdmin'];

          return Scaffold(
            backgroundColor: darkMode(),
            appBar: AppBar(
              centerTitle: true,
              iconTheme: IconThemeData(color: textColor()),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              actions: [
                if (snapshot.data['isAdmin'])
                  IconButton(
                    alignment: Alignment.centerRight,
                    iconSize: 32,
                    splashRadius: 25,
                    icon: Icon(Icons.add_circle_outline, color: textColor()),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return ModalPage(
                            projectId: projectId,
                          );
                        },
                      );
                    },
                  ),
                PopupMenuButton(
                    onSelected: (value) {
                      if (value == "SharedButton") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SharedButtonScreen(
                              projectId: projectId,
                              projectTitle: projectName,
                            ),
                          ),
                        );
                      }
                    },
                    icon: Icon(
                      Icons.more_vert,
                      color: textColor(),
                    ),
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          value: 'SharedButton',
                          child: Container(
                            child: Row(
                              children: [
                                Icon(Icons.phone_in_talk),
                                SizedBox(width: 10),
                                Text("FreeSpeak")
                              ],
                            ),
                          ),
                        ),
                      ];
                    }),
              ],
              backgroundColor: darkMode(),
              title: InkWell(
                onTap: () {},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      projectName,
                      style: TextStyle(color: textColor()),
                    ),
                  ],
                ),
              ),
            ),
            body: Center(
              child: Container(
                color: darkMode(),
                child: Column(
                  children: [
                    Expanded(
                        child: Messages(
                      projectId: projectId,
                    )),
                    NewMessage(
                      isAdmin: isAdmin,
                      projectId: projectId,
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
