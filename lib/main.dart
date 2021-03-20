import 'package:flutter/material.dart';
import 'package:project_amalgam/screens/Auth_Page/auth_page.dart';
import 'package:project_amalgam/screens/Settings_Page/settings_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Amalgam',
        routes: {
          SettingsPage.routeName: (context) => SettingsPage(),
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SettingsPage());
  }
}
