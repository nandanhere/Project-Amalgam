import 'package:flutter/material.dart';
import 'package:project_amalgam/Common_widgets/showProjects.dart';
import 'package:project_amalgam/globals.dart';

// N
class PublicProjectsScreen extends StatelessWidget {
  static const String routeName = '/PublicProjects';
  const PublicProjectsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkMode(),
      appBar: AppBar(
        title: Text(
          "Open Projects",
          style: TextStyle(color: textColor()),
        ),
        iconTheme: IconThemeData(color: textColor()),
        centerTitle: false,
        backgroundColor: darkMode(),
        elevation: 2,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
      ),
      body: SingleChildScrollView(
        child: ShowProjects(
          showPublic: true,
        ),
      ),
    );
  }
}
