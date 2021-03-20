import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
