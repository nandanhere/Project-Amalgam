import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../globals.dart';

class SharedButtonScreen extends StatelessWidget {
  final String projectId;
  final String projectTitle;
  const SharedButtonScreen(
      {Key key, this.projectId, @required this.projectTitle})
      : super(key: key);

  Future<void> buttonPress() async {
    FirebaseFirestore.instance.collection('projects').doc(projectId).update({
      'buttonPresser': {'userId': userIdGlobal, 'userName': userNameGlobal}
    });
    print("pressed");
  }

  Future<void> buttonRelease() async {
    await FirebaseFirestore.instance
        .collection('projects')
        .doc(projectId)
        .update({
      'buttonPresser': {'userId': 'none'}
    });
    print('released');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black87),
        backgroundColor: Color(0xFFE0E0E0),
        elevation: 2,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        title: Text(
          "FreeSpeak",
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: StreamBuilder(
          initialData: {
            'buttonPresser': {
              'userId': 'none',
            }
          },
          stream: FirebaseFirestore.instance
              .collection('projects')
              .doc(projectId)
              .snapshots(),
          builder: (context, snapShot) {
            final data = snapShot.data;
            final String currentPresser = data['buttonPresser']['userId'];
            final String userName = data['buttonPresser']['userName'];

            return Scaffold(
                backgroundColor: Color(0xFFE0E0E0),
                body: Center(child: Text(currentPresser)));
          }),
    );
  }
}
