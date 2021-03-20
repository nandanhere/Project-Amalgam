import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
 
 
 import 'package:holding_gesture/holding_gesture.dart';
import 'package:project_amalgam/globals.dart';

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
              body: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin: const EdgeInsets.only(bottom: 20.0),
                      child: Column(
                        children: [
                          Text("Team",
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 14)),
                          SizedBox(height: 5),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Color(0xffe0e0e0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    offset: Offset(0.5, 0.5),
                                    spreadRadius: 0.5,
                                    blurRadius: 0.5,
                                  ),
                                ]),
                            child: Text(projectTitle,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500)),
                          ),
                        ],
                      )),
                  HoldDetector(
                    onTap: () {},
                    holdTimeout: Duration(milliseconds: 500),
                    onHold: buttonPress,
                    onCancel: buttonRelease,
                    child: (currentPresser != 'none')
                        ? Container(
                            alignment: Alignment.center,
                            width: 250,
                            height: 250,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [
                                  Colors.black.withOpacity(0.0),
                                  Colors.black.withOpacity(0.2),
                                ],
                                center: AlignmentDirectional(0.0, 0.0),
                                focal: AlignmentDirectional(0.0, 0.0),
                                radius: 0.619,
                                focalRadius: 0.001,
                                stops: [0.75, 1.0],
                              ),
                            ),
                            child: Center(
                              child: Image.asset(
                                "assets/microphone_off.png",
                                height: 150,
                                width: 150,
                                fit: BoxFit.fitHeight,
                              ),
                            ))
                        : Container(
                            alignment: Alignment.center,
                            width: 250,
                            height: 250,
                            decoration: BoxDecoration(
                              color: Color(0xFFE0E0E0),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFFebebeb).withOpacity(0.5),
                                  offset: Offset(-3.0, -3.0),
                                  spreadRadius: 0.4,
                                  blurRadius: 4.0,
                                ),
                                BoxShadow(
                                  color: Color(0xFF4A4A4A).withOpacity(0.1),
                                  offset: Offset(3.0, 3.0),
                                  spreadRadius: 2,
                                  blurRadius: 5.0,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Image.asset(
                                "assets/microphone_on.png",
                                height: 150,
                                width: 150,
                                fit: BoxFit.fitHeight,
                              ),
                            )),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 30.0),
                      child: Column(
                        children: [
                          Text("Status",
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 14)),
                          SizedBox(height: 5),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Color(0xffe0e0e0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    offset: Offset(0.5, 0.5),
                                    spreadRadius: 0.5,
                                    blurRadius: 0.5,
                                  ),
                                ]),
                            child: Text(
                                (currentPresser != "none")
                                    ? (userName == userNameGlobal)
                                        ? "Line User : You"
                                        : "Line User : $userName"
                                    : "Line is Free",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500)),
                          ),
                        ],
                      )),
                ],
              )),
            );
          }),
    );
  }
}
