import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_amalgam/Common_widgets/CustomCircularProgressIndicator.dart';
import 'package:project_amalgam/screens/Chat_Page/ProjectInfoScreen.dart';
import 'package:project_amalgam/screens/Shared_Button_Screen/SharedButtonScreen.dart';
import 'package:project_amalgam/screens/Modal_Page/ModalPage.dart';
import '../../globals.dart';
import 'chat_page_widgets/messages.dart';
import 'chat_page_widgets/new_message.dart';

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
          List<String> tasks = List.castFrom(snapdata['tasks']);
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
              actions: [
                if (snapshot.data['isAdmin'])
                  IconButton(
                    alignment: Alignment.centerRight,
                    iconSize: 32,
                    splashRadius: 25,
                    icon: Icon(Icons.add_circle_outline, color: Colors.black87),
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
                    icon: Icon(Icons.more_vert),
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
              backgroundColor: Color(0xFFE0E0E0),
              title: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProjectInfoScreen(
                      isAdmin: isAdmin,
                      projectId: projectId,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      projectName,
                      style: TextStyle(color: Colors.black),
                    ),
                    //TODO make a setting where if only one task is there it will show the title of the task
                    if (!isAdmin)
                      Text(
                          (tasks.length == 0)
                              ? "No tasks have been assigned"
                              : (tasks.length == 1)
                                  ? tasks.first
                                  : 'You have been assigned ${tasks.length} task/s ',
                          style: TextStyle(color: Colors.black54, fontSize: 14))
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
