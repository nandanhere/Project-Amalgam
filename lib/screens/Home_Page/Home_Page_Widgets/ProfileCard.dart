import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_amalgam/Common_widgets/SizeSpecifier.dart';

import '../../../globals.dart';

class FutureProfileCard extends StatelessWidget {
  const FutureProfileCard({Key key, @required this.type}) : super(key: key);
  final DeviceType type;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc(userIdGlobal)
          .get(),
      initialData: {
        'userName': 'Loading',
        'email': 'Loading',
        'role': 'Loading',
        'pointsEarnedInTotal': 0,
        'imageUrl': null
      },
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        final data = snapshot.data;
        return ProfileCard(
          dataMap: data,
          type: type,
        );
      },
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key key, @required this.type, this.dataMap})
      : super(key: key);
  final DeviceType type;
  final dynamic
      dataMap; // it is supposed to be DocumentSnapshot but it keeps giving error at that so i did this.

  @override
  Widget build(BuildContext context) {
    final splitName =
        (dataMap['userName'] as String).split(" ").map((e) => e.trim());
    final email = (dataMap['email'] as String);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.all(5),
      height: height / 3.5 < 250 ? height / 3.5 : 250,
      width: width / 1.5,
      decoration: BoxDecoration(
          color: Color(0xFFC6C0EC),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFE2DEFF).withOpacity(0.5),
              offset: Offset(-3.0, -3.0),
              blurRadius: 3.0,
            ),
            BoxShadow(
              color: Color(0xFF858396).withOpacity(0.2),
              offset: Offset(3.0, 3.0),
              blurRadius: 3.0,
            ),
          ],
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(100),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20))),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(100),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          onTap: () {},
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 0,
                          spreadRadius: 2,
                          color: Color(0xFFE0E0E0),
                          offset: Offset(0, 0))
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundImage: dataMap['imageUrl'] == null
                        ? null
                        : NetworkImage(dataMap['imageUrl']),
                    radius: returner(type, 38, 43, 43),
                    child: dataMap['imageUrl'] == null
                        ? Text(splitName.first.toUpperCase(),
                            style: GoogleFonts.ubuntu(fontSize: 25))
                        : null,
                  ),
                ),
              ),
              if (dataMap['pointsEarnedInTotal'] != 0)
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, right: 5),
                    child: Text(" ${dataMap['pointsEarnedInTotal']} ⭐️ ",
                        style: GoogleFonts.ubuntu(
                            fontWeight: FontWeight.w400,
                            fontSize: returner(type, 13, 18, 20))),
                  ),
                ),
              Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10, right: 5),
                      padding: EdgeInsets.only(left: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Text(
                                (splitName.length > 1)
                                    ? splitName.first + " " + splitName.last
                                    : splitName.first,
                                style: GoogleFonts.ubuntu(
                                    fontWeight: FontWeight.w400,
                                    fontSize: returner(type, 16, 18, 20))),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 3, right: 5),
                      padding: EdgeInsets.only(left: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Text(email,
                                style: GoogleFonts.ubuntu(
                                    fontWeight: FontWeight.w400,
                                    fontSize: returner(type, 14, 16, 18))),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: EdgeInsets.only(top: 20, right: 5),
                  padding: EdgeInsets.only(left: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text("Amalgam | Bangalore",
                            style: GoogleFonts.ubuntu(
                                fontWeight: FontWeight.w400,
                                fontSize: returner(type, 16, 18, 20))),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Container(
                    margin: EdgeInsets.only(right: 5, bottom: 10),
                    child: Wrap(spacing: 2, runSpacing: 2, children: [
                      UserRole(type: type, text: dataMap['role']),
                    ]),
                  ),
                ),
              ),
              Align(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0, bottom: 10),
                  child: Text(" ${dataMap['pointsEarnedInTotal']} ⭐️ ",
                      style: GoogleFonts.ubuntu(
                          fontWeight: FontWeight.w400,
                          fontSize: returner(type, 16, 18, 20))),
                ),
                alignment: Alignment.bottomLeft,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class UserRole extends StatelessWidget {
  const UserRole({Key key, @required this.type, @required this.text})
      : super(key: key);

  final DeviceType type;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 5, left: 5, top: 1, bottom: 1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: Colors.pink[900], width: 1.5),
      ),
      child: Text(text,
          style: GoogleFonts.ubuntu(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: returner(type, 16, 18, 20))),
    );
  }
}
