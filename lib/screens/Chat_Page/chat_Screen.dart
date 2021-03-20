import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_amalgam/Common_widgets/CustomCircularProgressIndicator.dart';

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
              backgroundColor: Color(0xFFE0E0E0),
              body: Center(
                child: CustomProgressIndicator(),
              ),
            );
          }
          final snapdata = snapshot.data;
          print(snapdata['isAdmin']);
          isAdmin = snapdata['isAdmin'];

          return Scaffold(
            backgroundColor: Color(0xFFE0E0E0),
            appBar: AppBar(
              centerTitle: true,
              iconTheme: IconThemeData(color: Colors.black87),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              backgroundColor: Color(0xFFE0E0E0),
              title: InkWell(
                onTap: () {},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      projectName,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            body: Center(
              child: Container(
                color: Color(0xFFE0E0E0),
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
