import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:project_amalgam/Common_widgets/SizeSpecifier.dart';
import 'package:project_amalgam/Common_widgets/projectDetails.dart';

import '../../../globals.dart';
import 'Functions.dart';

class MemberDisplayer extends StatefulWidget {
  final String projectId;
  const MemberDisplayer({Key key, this.projectId}) : super(key: key);
  @override
  _MemberDisplayerState createState() => _MemberDisplayerState();
}

class _MemberDisplayerState extends State<MemberDisplayer> {
  List<String> uids;
  List<Member> members = [];
// final EmpWork emp;
  Future<void> userListRetriever() async {
    var doc = await FirebaseFirestore.instance
        .collection("projects")
        .doc(widget.projectId)
        .get();
    uids = List.castFrom(doc["userList"]);
  }

  Future<void> memberMaker() async {
    for (int i = 0; i < uids.length; i++) {
      var doc = await FirebaseFirestore.instance
          .collection("users")
          .doc(uids[i])
          .get();
      var coldoc = await FirebaseFirestore.instance
          .collection("projects")
          .doc(widget.projectId)
          .collection('userData')
          .doc(uids[i])
          .get();
      members.add(Member(doc["userName"].toString(), doc["role"].toString(),
          colorList[coldoc["color"]], doc["userId"].toString()));
    }
  }

  @override
  void initState() {
    userListRetriever().then((value) {
      memberMaker().then((value) {
        setState(() {});
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
        margin: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
        height: returner(widthdecider(width), 130, 160, 170),
        width: width,
        decoration: BoxDecoration(
            color: Color(0xFFe9e9e9),
            // border: Border(),
            boxShadow: [
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
            ],
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: horizMemsRow(members, width),
          scrollDirection: Axis.horizontal,
        ));
  }
}

class MemberViewer extends StatelessWidget {
  const MemberViewer({
    Key key,
    @required this.member,
  }) : super(key: key);
  final Member member;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: returner(widthdecider(width), 65, 75, 75),
      // color: Colors.pink,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              CircleAvatar(
                  radius: returner(widthdecider(width), 25, 30, 30),
                  backgroundColor: Colors.blue.withAlpha(50),
                  child: Text(
                    member.name[0],
                    style: TextStyle(
                        fontSize: returner(widthdecider(width), 20, 24, 24),
                        color: Colors.black),
                  )),
              Positioned(
                right: -3,
                top: -5,
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: member.uniqCol.withAlpha(100),
                  child:
                      CircleAvatar(radius: 4, backgroundColor: member.uniqCol),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Text(
              member.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: returner(widthdecider(width), 12, 14, 14)),
            ),
          ),
          Text(
            member.role,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: returner(widthdecider(width), 12, 14, 14)),
          ),
        ],
      ),
    );
  }
}
