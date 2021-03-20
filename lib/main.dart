import 'package:flutter/material.dart';
import 'package:project_amalgam/screens/Auth_Page/auth_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Amalgam',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AuthScreen());
  }
}
