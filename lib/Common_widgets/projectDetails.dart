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
