
import 'package:flutter/material.dart';

import 'Auth_Page_Widgets/auth_form_card.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({Key key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color(0xFF329EF4).withOpacity(0.3),
              Color(0xFF329EF4).withOpacity(0.25),
              Color(0xFF329EF4).withOpacity(0.2),
              Color(0xFF329EF4).withOpacity(0.1),
            ]),
      ),
      child: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: Stack(children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 75,
                              child: Image.asset(
                                "assets/amalgam_logo.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Column(
                              children: [
                                Text(
                                  "Amalgam",
                                  style: TextStyle(
                                      fontSize: 34,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  "Redefining Workspace",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ],
                        ),
                        AuthForm(isLoading: _isLoading),
                      ],
                    )
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}