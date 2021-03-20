import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../globals.dart';

// when a user tries to join a project that is open , they will come accross this screen. so they can join . essentially this will add their uid to the project's userData

class ProjectPreview extends StatelessWidget {
  final String projectName;
  final String projectId;
  final String imageUrl;
  final String projectDesc;
  const ProjectPreview(
      {Key key,
      @required this.projectName,
      @required this.projectId,
      @required this.imageUrl,
      @required this.projectDesc})
      : super(key: key);

  Future<void> joinGroup() async {
    final data = await FirebaseFirestore.instance
        .collection('projects')
        .doc(projectId)
        .get();
    final list = data.data()['userList'] + [userIdGlobal];
    await FirebaseFirestore.instance
        .collection('projects')
        .doc(projectId)
        .collection("userData")
        .doc(userIdGlobal)
        .set({
      "color": list.length - 1,
      "isAdmin": false,
      "uid": userIdGlobal,
      'tasks': ['none']
    });
    await FirebaseFirestore.instance
        .collection('projects')
        .doc(projectId)
        .update({'userList': list});
    print("Group Joined!");
  }

  @override
  Widget build(BuildContext context) {
    print(imageUrl);
    return Scaffold(
      appBar: AppBar(
        title: Text("Open Project : $projectName"),
      ),
      body: Center(
        child: Column(
          children: [
            CircleAvatar(
              child: imageUrl == null ? Icon(Icons.group) : null,
              backgroundImage: imageUrl == null ? null : NetworkImage(imageUrl),
            ),
            Text(projectDesc),
            TextButton(
                onPressed: () {
                  joinGroup();
                },
                child: Text("Join project"))
          ],
        ),
      ),
    );
  }
}
