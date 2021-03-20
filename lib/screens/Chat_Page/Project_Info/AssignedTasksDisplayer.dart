import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_amalgam/Common_widgets/SizeSpecifier.dart';
import 'package:project_amalgam/Common_widgets/projectDetails.dart';

import '../../../globals.dart';
import 'Functions.dart';

class MemberColumnBar extends StatelessWidget {
  const MemberColumnBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 5),
      height: 50,
      width: returner(widthdecider(width), (width < 500) ? 500 : width,
          (width < 700) ? 700 : width, (width < 700) ? 700 : width),
      // padding: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: returner(widthdecider(width), 25, 35, 35),
            child: Icon(
              Icons.flag_outlined,
              color: Colors.black54,
            ),
          ),
          Container(
            child: Text(
              "Due Date",
              textAlign: TextAlign.center,
            ),
            width: returner(widthdecider(width), 75, 95, 95),
          ),
          // SizedBox(width: width / 6),
          Container(
            width: returner(widthdecider(width), 150, 175, 175),
            child: Text(
              "Title",
              textAlign: TextAlign.center,
            ),
          ),
          // SizedBox(width: width / 10),
          Container(
            // alignment: Alignment.center,
            width: returner(widthdecider(width), 95, 115, 115),
            child: Text(
              "Status",
              textAlign: TextAlign.center,
            ),
            padding: EdgeInsets.all(7),
          ),
          // SizedBox(width: width / 15),
          Container(
            width: returner(widthdecider(width), 100, 150, 150),
            child: Text(
              "Asignee",
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}

class MemberTaskCard extends StatelessWidget {
  const MemberTaskCard(
      {Key key,
      @required this.task,
      @required this.col,
      @required this.projectId,
      @required this.reseter})
      : super(key: key);

  final Task task;
  final bool col;
  final String projectId;
  final void Function() reseter;
  Widget statusButtonColumn(Task task) {
    List<Widget> col = [];
    for (int i = 0; i < status.length; i++) {
      if (task.status == status[i]) continue;
      col.add(StatusButton(
        status: status[i],
        value: i,
        task: task,
        projectId: projectId,
      ));
      col.add(SizedBox(height: 3));
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: col,
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 5),
      height: 50,
      alignment: Alignment.center,
      // padding: EdgeInsets.only(left: 10, right: 10),
      width: returner(widthdecider(width), (width < 500) ? 500 : width,
          (width < 700) ? 700 : width, (width < 700) ? 700 : width),
      decoration: BoxDecoration(
          color: (col == true) ? Color(0xFFE9E9E9) : Colors.transparent,
          // border: Border(),
          boxShadow: (col == true)
              ? [
                  BoxShadow(
                    color: Color(0xFFffffff).withOpacity(0.5),
                    offset: Offset(-3.0, -3.0),
                    blurRadius: 3.0,
                  ),
                  BoxShadow(
                    color: Color(0xFF000000).withOpacity(0.1),
                    offset: Offset(3.0, 3.0),
                    blurRadius: 3.0,
                  ),
                ]
              : [],
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                alignment: Alignment.center,
                width: returner(widthdecider(width), 25, 35, 35),
                child: CircleAvatar(
                  radius: returner(widthdecider(width), 10, 15, 15),
                  backgroundColor: task.col.withAlpha(100),
                  child: CircleAvatar(
                      radius: returner(widthdecider(width), 3, 4, 4),
                      backgroundColor: task.col),
                ),
              ),
              Container(
                width: returner(widthdecider(width), 75, 95, 95),
                alignment: Alignment.center,
                // color: Colors.pink,
                child: Text(
                  dateTeller(task.date).toString(),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: returner(widthdecider(width), 12, 14, 14)),
                ),
              ),
              Container(
                width: returner(widthdecider(width), 150, 175, 175),
                alignment: Alignment.center,
                child: Text(
                  task.title,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: returner(widthdecider(width), 12, 14, 14)),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: statColor(task.status).withAlpha(100),
                  padding: EdgeInsets.all(7),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
                onPressed: () {},
                child: Container(
                  width: returner(widthdecider(width), 95, 115, 115),
                  child: Text(
                    task.status.toUpperCase(),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: statColor(task.status),
                        fontWeight: FontWeight.bold,
                        fontSize: returner(widthdecider(width), 12, 14, 14)),
                  ),
                ),
              ),
              Container(
                width: returner(widthdecider(width), 100, 150, 150),
                alignment: Alignment.center,
                // color: Colors.pink,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                        radius: returner(widthdecider(width), 10, 15, 15),
                        backgroundColor: Colors.blue,
                        child: Text(task.empName[0])),
                    Container(
                      // color: Colors.pink,
                      alignment: Alignment.center,
                      width: returner(widthdecider(width), 75, 100, 100),
                      child: Text(
                        task.empName,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:
                                returner(widthdecider(width), 12, 14, 14)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return Dialog(
                          backgroundColor: Color(0xffe0e0e0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: IntrinsicWidth(
                              child: SingleChildScrollView(
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        "Update The Status",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      statusButtonColumn(task),
                                    ]),
                              ),
                            ),
                          ),
                        );
                      }).then((value) {
                    reseter();
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class StatusButton extends StatelessWidget {
  StatusButton({Key key, this.status, this.value, this.projectId, this.task})
      : super(key: key);
  final String status;
  final int value;
  final String projectId;
  final Task task;
  statusAssigner() async {
    var doc = await FirebaseFirestore.instance
        .collection("projects")
        .doc(projectId)
        .collection("tasks")
        .doc(task.taskId)
        .get();
    var arr = doc["assignees"].map((e) => e).toList();
    var uids = arr.map((e) => e.keys.first.toString()).toList();
    int i;
    for (i = 0; i < uids.length; i++) {
      if (uids[i] == task.uid) {
        break;
      }
    }
    arr[i][uids[i]] = value;
    await FirebaseFirestore.instance
        .collection("projects")
        .doc(projectId)
        .collection("tasks")
        .doc(task.taskId)
        .update({"assignees": arr});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10),
      child: ElevatedButton(
        onPressed: () {
          statusAssigner();
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Please wait while the status gets updated"),
            backgroundColor: Colors.green,
          ));
        },
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.grey,
          primary: statColor(status).withAlpha(100),
          padding: EdgeInsets.all(7),
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
        ),
        child: Text(
          status.toUpperCase(),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: statColor(status),
              fontWeight: FontWeight.bold,
              fontSize: 14),
        ),
      ),
    );
  }
}
