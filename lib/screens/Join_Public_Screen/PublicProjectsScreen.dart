import 'package:flutter/material.dart';
import 'package:project_amalgam/Common_widgets/showProjects.dart';

// N
class PublicProjectsScreen extends StatelessWidget {
  static const String routeName = '/PublicProjects';
  const PublicProjectsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0E0E0),
      appBar: AppBar(
        title: Text(
          "Open Projects",
          style: TextStyle(color: Colors.black87),
        ),
        iconTheme: IconThemeData(color: Colors.black87),
        centerTitle: false,
        backgroundColor: Color(0xFFE0E0E0),
        elevation: 2,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
      ),
      body: ShowProjects(
        showPublic: true,
      ),
    );
  }
}
