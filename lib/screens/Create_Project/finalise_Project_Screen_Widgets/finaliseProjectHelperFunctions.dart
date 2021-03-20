import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../globals.dart';

// it is better to initialise the data beforehand so i will just create data entities so that
// editing them later is easier
class HelperFunctions {
  static void finaliseProjectDetails(
    String projectDesc,
    String projectName,
    bool isPrivate,
    List<String> list,
    Map<String, DocumentSnapshot> data,
  ) async {
    String projectId;
    await FirebaseFirestore.instance.collection("projects").add({
      "projectDesc": projectDesc,
      "projectName": projectName,
      'isPrivate': isPrivate,
      "userList": list + [userIdGlobal],
      "buttonPresser": {'userId': "none"},
      'tasks': []
    }).then((value) {
      projectId = value.id;
    });
    final List<String> tasks = [];

    FirebaseFirestore.instance.collection("projects").doc(projectId).update({
      "projectId": projectId,
    });
    FirebaseFirestore.instance
        .collection('projects')
        .doc(projectId)
        .collection("tasks")
        .add({'name': 'initialiserTaskDoNotUse'});
    FirebaseFirestore.instance
        .collection('projects')
        .doc(projectId)
        .collection("userData")
        .doc(userIdGlobal)
        .set(
            {"color": 0, "isAdmin": true, "uid": userIdGlobal, "tasks": tasks});

    FirebaseFirestore.instance
        .collection('projects')
        .doc(projectId)
        .collection("chat")
        .add({
      'text':
          "Welcome to the $projectName ! You can start sending messages here",
      'time': Timestamp.now(),
      'userId': "spec_message_for_welcome",
      'userName': "Amalgam Team",
    });

    for (int i = 0; i < list.length; i++) {
      FirebaseFirestore.instance
          .collection('projects')
          .doc(projectId)
          .collection("userData")
          .doc(list[i])
          .set({
        "color": i + 1,
        "isAdmin": false,
        "uid": list[i],
        'tasks': tasks
      });
    }
  }
}
