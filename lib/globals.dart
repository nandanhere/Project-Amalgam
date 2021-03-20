import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

double width = 0.0;
List<Color> colorList = [
  Colors.blue,
  Colors.green,
  Colors.pink,
  Colors.cyan,
  Colors.purple,
  Colors.lime,
  Colors.yellow,
  Colors.teal,
  Colors.indigo,
  Colors.orange
];
String userIdGlobal = "";
String userNameGlobal = "";
Future<void> setGlobaluserId(String uid) async {
  userIdGlobal = uid;
  final userFile = await FirebaseFirestore.instance
      .collection("users")
      .doc(userIdGlobal)
      .get();
  userNameGlobal = userFile.data()['userName'];
}

void setDeviceWidth(double value) {
  width = value;
}
