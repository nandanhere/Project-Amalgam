 import 'dart:ui';
 
class ProjectDetails {
  String title;
  String id;
  String admin;
  int tasksDone;
  List<String> categories;
  String description;
  String role;
  DateTime deadLine;
  String imageUrl;
  int points;
  ProjectDetails(
      {String title,
      String id,
      String admin,
      String role,
      int tasksDone,
      List<String> categories,
      String description,
      DateTime date,
      int points,
      String url})
      : this.role = role,
        this.description = description,
        this.deadLine = date,
        this.points = points,
        this.imageUrl = url,
        this.title = title,
        this.id = id,
        this.admin = admin,
        this.tasksDone = tasksDone,
        this.categories = categories;
}

class Member {
  String name;
  String uid;
  String role;
  Color uniqCol;
  Member(this.name, this.role, this.uniqCol, [this.uid]);
}

class Task {
  Color col;
  DateTime date;
  String title;
  String status;
  String empName;
  String uid;
  String taskId;
  Task(this.col, this.date, this.title, this.status, this.empName, this.uid,
      this.taskId);
}
