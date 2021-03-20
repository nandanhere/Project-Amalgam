import 'package:cloud_firestore/cloud_firestore.dart';

double width = 0.0;

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
