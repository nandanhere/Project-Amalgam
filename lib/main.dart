import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_amalgam/screens/Auth_Page/auth_page.dart';
import 'package:project_amalgam/screens/Home_Page/Home_Page.dart';
import 'package:project_amalgam/screens/Settings_Page/settings_page.dart';

import 'screens/Create_Project/finaliseProject.dart';
import 'screens/Create_Project/selectMembersScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final app = MaterialApp(
      title: 'Amalgam',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.grey,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.pink,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasData) {
            return HomePage();
          }
          return AuthScreen();
        },
      ),
      routes: {
        HomePage.routeName: (ctx) => HomePage(),
        SettingsPage.routeName: (ctx) => SettingsPage(),
        SelectMembersScreen.routeName: (ctx) => SelectMembersScreen(),
        FinaliseProjectScreen.routeName: (ctx) => FinaliseProjectScreen(),
      },
    );
    return FutureBuilder(
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.done)
          return app;
        else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
      future: Firebase.initializeApp(),
    );
  }
}
