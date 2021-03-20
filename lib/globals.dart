import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

bool isDark = true;
Color darkMode() {
  if (isDark) {
    return Color(0xFF363940);
  } else {
    return Color(0xFFE0E0E0);
  }
}

Color textColor() {
  if (isDark) {
    return Colors.grey;
  } else {
    return Colors.black87;
  }
}

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
