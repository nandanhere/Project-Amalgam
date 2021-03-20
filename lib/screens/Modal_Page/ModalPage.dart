import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_amalgam/Common_widgets/BoldText.dart';
import 'package:project_amalgam/Common_widgets/SizeSpecifier.dart';
import 'package:project_amalgam/Common_widgets/SubText.dart';
import 'package:project_amalgam/Common_widgets/projectDetails.dart';

import '../../globals.dart';
import 'Modal_Screen_Widgets/AssignButton.dart';
import 'Modal_Screen_Widgets/CategoryCard.dart';
import 'Modal_Screen_Widgets/CompanyName.dart';
import 'Modal_Screen_Widgets/DeadlineElements.dart';
import 'Modal_Screen_Widgets/DescripBox.dart';
import 'Modal_Screen_Widgets/ModalHeader.dart';
import 'Modal_Screen_Widgets/PointsAndCoupons.dart';
import 'Modal_Screen_Widgets/TaskNameTextField.dart';

class ModalPage extends StatefulWidget {
  final String projectId;

  const ModalPage({Key key, @required this.projectId}) : super(key: key);
  @override
  _ModalPageState createState() => _ModalPageState();
}

class _ModalPageState extends State<ModalPage> {
  String taskName = 'No_Name__For_Task';
  String taskDesc = 'No_Description_For_Task';
  int points = 0;
  DateTime deadLine = DateTime.now();
  List<Color> accColors = Colors.accents.toList();
  List<Widget> categories = [];
  List<String> uids;
  List<Member> members = [];
  TextEditingController titleCtr = TextEditingController(),
      descripCtr = TextEditingController(),
      ptsCtr = TextEditingController();
  List<TextEditingController> categoryCtr = [TextEditingController()];
  Future<void> userListRetriever() async {
    var doc = await FirebaseFirestore.instance
        .collection("projects")
        .doc(widget.projectId)
        .get();
    uids = List.castFrom(doc["userList"]);
  }

  void changeTaskName(String name) {
    taskName = name;
  }

  void changeDeadLine(DateTime newDeadLine) {
    deadLine = newDeadLine;
  }

  void changePoints(int newPoints) {
    points = newPoints;
  }

  void changeTaskDesc(String desc) {
    taskDesc = desc;
  }

  void changeCategoriesList(List<String> newCategoriesList) {}

  memberMaker() async {
    for (int i = 0; i < uids.length; i++) {
      var doc = await FirebaseFirestore.instance
          .collection("users")
          .doc(uids[i])
          .get();
      members.add(Member(doc["userName"].toString(), doc["role"].toString(),
          Colors.blue, doc["userId"].toString()));
    }
  }

  Future<void> assignTask() async {
    final projData = await FirebaseFirestore.instance
        .collection('projects')
        .doc(widget.projectId)
        .get();
    List<dynamic> taskList = projData.data()['tasks'];
    final List<Map<String, int>> uidList = [];
    assigneesPt.forEach((key, value) {
      uidList.add({key.uid: 0});
    });
    await FirebaseFirestore.instance
        .collection('projects')
        .doc(widget.projectId)
        .collection('tasks')
        .add({
      'assignerName': userNameGlobal,
      'assignerUid': userIdGlobal,
      'taskName': taskName,
      'taskDesc': taskDesc,
      'points': points,
      'deadLine': deadLine,
      'taskId': "idk",
      'assignees': uidList,
      'categories': categoryCtr.map((e) {
        if (e.text.length > 0) return e.text;
      }).toList()
    }).then((value) async {
      taskList.add(value.id);
      await FirebaseFirestore.instance
          .collection('projects')
          .doc(widget.projectId)
          .collection('tasks')
          .doc(value.id)
          .update({"taskId": value.id});
    });
    await FirebaseFirestore.instance
        .collection('projects')
        .doc(widget.projectId)
        .update({"tasks": taskList});
    for (int i = 0; i < uidList.length; i++) {
      var doc = await FirebaseFirestore.instance
          .collection("users")
          .doc(uidList[i].keys.first)
          .get();
      int points1 = doc["balance"], points2 = doc["pointsEarnedInTotal"];
      points1 += points;
      points2 += points;
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uidList[i].keys.first)
          .set({"balance": points1, "pointsEarnedInTotal": points2});
    }
    print('done');
  }

  @override
  void initState() {
    userListRetriever().then((value) {
      memberMaker();
    });
    super.initState();
  }

// this is for categories
  void _inserter() {
    accColors.shuffle();
    categoryCtr.add(TextEditingController());
    Color x = accColors[0];
    textCache.add("");
    categories.add(Row(
      key: Key(x.hashCode.toString()),
      children: [
        SizedBox(
          width: 10,
        ),
        CategoryCard(
          ctr: categoryCtr.last,
          suffwid: InkWell(
            child: Icon(
              Icons.remove_circle_outline_outlined,
              color: Colors.red,
            ),
            onTap: () {
              int i;
              for (i = 0; i < categories.length; i++) {
                if (categories[i].key == Key(x.hashCode.toString())) {
                  break;
                }
              }
              categories.removeAt(i);
              categoryCtr.removeAt(i);
              setState(() {});

              textCache.removeLast();
            },
          ),
          color: x,
        ),
      ],
    ));
    accColors.removeAt(0);
  }

  Map<Member, int> assigneesPt = Map<Member, int>();

  void appendAssignee(Member m) {
    if (assigneesPt.containsKey(m)) {
      return;
    }
    assigneesPt[m] = 0;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Dialog(
      elevation: 0,
      insetPadding: widthdecider(width) == DeviceType.Mobile
          ? EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 30)
          : EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Color(0xFFE0E0E0),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Color(0xFFffffff),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ModalHeader(),
                  CompanyName(str: "Assign a task"),
                ],
              ),
            ),
            Column(
              children: [
                Padding(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.ideographic,
                      children: [
                        BoldText(str: "Task Name"),
                        SizedBox(width: 5),
                        SubText(str: "(10 words)"),
                      ],
                    )),
                TaskNameTextField(
                  changeTaskName: changeTaskName,
                  ctr: titleCtr,
                ),
                Container(
                  height: 80,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CategoryCard(
                            suffwid: Container(height: 0, width: 0),
                            color: Colors.redAccent,
                            ctr: categoryCtr.first,
                          ),
                          Row(
                            children: categories,
                          ),
                          SizedBox(width: 10),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.blue,
                              radius: 24,
                              child: IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    textCache = textCache;
                                  });
                                  if (textCache[textCache.length - 1] == "") {
                                    return;
                                  }
                                  setState(() {
                                    _inserter();
                                  });
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Row(children: [
                BoldText(str: "Assignee"),
              ]),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: DropdownSearch(
                label: "Enter Assignee Names",
                dropDownButton: Icon(
                  Icons.arrow_circle_down,
                  color: Colors.black54,
                ),
                mode: Mode.MENU,
                itemAsString: (obj) => obj.name + " | " + obj.role,
                dropdownBuilder: (context, data, str) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: assigneesPt.keys.map((e) {
                      return Container(
                        decoration: BoxDecoration(
                            color: Color(0xFFf0f0f0),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFebebeb).withOpacity(0.5),
                                offset: Offset(-3.0, -3.0),
                                blurRadius: 3.0,
                              ),
                              BoxShadow(
                                color: Color(0xFF4A4A4A).withOpacity(0.1),
                                offset: Offset(3.0, 3.0),
                                blurRadius: 3.0,
                              ),
                            ],
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        margin: EdgeInsets.only(top: 10, bottom: 10, left: 5),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(e.name),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.clear,
                                  size: 20,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  assigneesPt.remove(e);
                                  setState(() {});
                                },
                              ),
                            ]),
                      );
                    }).toList()),
                  );
                },
                showSearchBox: true,
                searchBoxDecoration: InputDecoration(helperText: "Search Name"),
                items: members,
                onChanged: (val) {
                  appendAssignee(val);
                  setState(() {});
                },
              ),
            ),
            Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.ideographic,
                  children: [
                    BoldText(str: "Task Description"),
                    SizedBox(width: 5),
                    SubText(str: "(35 words)")
                  ],
                )),
            DescripBox(
              changeTaskDesc: changeTaskDesc,
              ctr: descripCtr,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: BoldText(str: "Deadline"),
            ),
            DeadlineElements(
              changeDeadLine: changeDeadLine,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: BoldText(str: "Points"),
            ),
            PointsAndCoupons(
              changePoints: changePoints,
              ctr: ptsCtr,
            ),
            AssignButton(
              execute: assignTask,
            ),
          ],
        ),
      ),
    );
  }
}
