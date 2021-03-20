import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:project_amalgam/Common_widgets/projectDetails.dart';

import '../../globals.dart';
import 'Project_Info/AssignedTasksDisplayer.dart';
import 'Project_Info/ButtonRow.dart';
import 'Project_Info/HorizontalMemberList.dart';
import 'Project_Info/ProjectDescription.dart';
import 'Project_Info/StatsInfo.dart';

class ProjectInfoScreen extends StatefulWidget {
  final bool isAdmin;
  final String projectId;
  @override
  _ProjectInfoScreenState createState() => _ProjectInfoScreenState();
  ProjectInfoScreen({Key key, this.isAdmin, this.projectId}) : super(key: key);
}

class _ProjectInfoScreenState extends State<ProjectInfoScreen> {
  void reset() {
    setState(() {});
  }

  var documentList;

  List<Task> tasks = [];
// final EmpWork emp;
  Future<void> taskDataRetriever() async {
    var doc = await FirebaseFirestore.instance
        .collection("projects")
        .doc(widget.projectId)
        .collection("tasks")
        .get();
    documentList = doc.docs.map((e) => e.data()).toList();
  }

  Future<void> taskFormatter() async {
    for (int i = 0; i < documentList.length; i++) {
      Map task = documentList[i];
      DateTime deadLine = task["deadLine"].toDate() == null
          ? DateTime.now()
          : task["deadLine"].toDate();
      String title = task["taskName"];
      String taskId = task["taskId"];
      print(title);
      var statusMap = task["assignees"].map((e) => e).toList();
      var uids = statusMap.map((e) => e.keys.first.toString()).toList();
      for (int j = 0; j < uids.length; j++) {
        var coldoc = await FirebaseFirestore.instance
            .collection("projects")
            .doc(widget.projectId)
            .collection('userData')
            .doc(uids[j])
            .get();
        var userDetails = await FirebaseFirestore.instance
            .collection("users")
            .doc(uids[j])
            .get();
        tasks.add(Task(
            colorList[coldoc["color"]],
            deadLine,
            title,
            status[statusMap[j][uids[j]]],
            userDetails["userName"],
            uids[j],
            taskId));
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    taskDataRetriever().then((value) {
      taskFormatter().then((value) {
        setState(() {});
      });
    });
    print(tasks.map((e) => e.title));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget lister() {
      List<Widget> list = [];
      bool yes = true;
      for (int i = 0; i < tasks.length; i++) {
        list.add(MemberTaskCard(
            task: tasks[i],
            col: yes,
            projectId: widget.projectId,
            reseter: () {
              Timer(Duration(seconds: 5), () {
                tasks = [];
                taskDataRetriever().then((value) {
                  taskFormatter().then((value) {
                    setState(() {});
                  });
                });
              });
            }));
        yes = !yes;
      }
      return Column(children: list);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Project Details",
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FutureBuilder(
                initialData: {'projectDesc': 'loading'},
                future: FirebaseFirestore.instance
                    .collection('projects')
                    .doc(widget.projectId)
                    .get(),
                builder: (context, snap) {
                  final data = snap.data;
                  return Column(
                    children: [
                      StatsInfo(
                        role: 'role',
                      ),
                      ButtonRow(),
                      ProjDescrip(
                        projectDesc: data['projectDesc'],
                      ),
                    ],
                  );
                }),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 28.0),
              child: Text(
                "Projects",
                style: TextStyle(fontSize: 25),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MemberColumnBar(),
                  lister(),
                  SizedBox(
                    height: 8,
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child: Center(
                child: InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.arrow_circle_down,
                      size: 25,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 28.0),
              child: Text(
                "Members",
                // textAlign: TextAlign.start,
                style: TextStyle(fontSize: 25),
              ),
            ),
            MemberDisplayer(
              projectId: widget.projectId,
            )
          ],
        ),
      ),
    );
  }
}

// class ProjectInfoScreen extends StatelessWidget {
//   final bool isAdmin;
//   final String projectId;
//   ProjectInfoScreen(this.isAdmin, this.projectId);

// }
