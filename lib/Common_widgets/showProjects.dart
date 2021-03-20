import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_amalgam/Common_widgets/projectDetails.dart';

import '../globals.dart';
import 'CustomCard.dart';
import 'CustomCircularProgressIndicator.dart';

class ShowProjects extends StatelessWidget {
  final bool showPublic;
  const ShowProjects({Key key, this.showPublic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    Widget dualProjectViewer(List<Widget> card) {
      List<Widget> c1 = [], c2 = [];
      for (int i = 0; i < card.length; i++) {
        if (i % 2 == 0)
          c1.add(card[i]);
        else
          c2.add(card[i]);
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: c1,
          ),
          Column(
            children: c2,
          )
        ],
      );
    }

    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('projects').snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CustomProgressIndicator(),
          );
        }
        List<QueryDocumentSnapshot> chatDoc = snapshot.data.documents;
        List<Widget> groups = [];
        chatDoc.forEach((doc) {
          final data = doc.data();

          if (showPublic) {
            if (!data['isPrivate']) if (!(data['userList'] as List<dynamic>)
                .contains(userIdGlobal)) {
              ProjectDetails projDeets = new ProjectDetails(
                  title: data['projectName'],
                  id: data['projectId'],
                  admin: 'no',
                  categories: [],
                  date: DateTime.now(),
                  description: data['projectDesc'],
                  points: 0,
                  role: "no role",
                  url: data['imageUrl'],
                  tasksDone: 0);

              groups.add(CustomCard(
                details: projDeets,
                isOpen: showPublic,
              ));
            }
          } else {
            final List<dynamic> userList = data['userList'];
            if (userList.contains(userIdGlobal)) {
              ProjectDetails emp = new ProjectDetails(
                  admin: 'no',
                  categories: [],
                  date: DateTime.now(),
                  description: data['projectDesc'],
                  id: data['projectId'],
                  points: 10,
                  role: "no role",
                  url: data['imageUrl'],
                  title: data['projectName'],
                  tasksDone: 0);

              groups.add(CustomCard(
                details: emp,
                isOpen: showPublic,
              ));
            }
          }
        });

        return (width >= 720)
            ? dualProjectViewer(groups)
            : Column(children: groups);
      },
    );
  }
}
