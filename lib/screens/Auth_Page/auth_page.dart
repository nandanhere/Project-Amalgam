import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Auth_Page_Widgets/auth_form_card.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = '/authscreen';
  AuthScreen({Key key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _isLoading = false;

  final auth = FirebaseAuth.instance; // N

  void _submitAuthForm(String email, String password, String userName,
      String role, bool isLogin, BuildContext ctx, File imageFile) async {
    UserCredential authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        String imageUrl = 'none';
// here i have referenced stockimageReference which is a stock image that will be displayed if the person does not have an image.
        final reference = FirebaseStorage.instance
            .ref()
            .child('userImages')
            .child(imageFile == null
                ? "stockImageReference.jpg"
                : '${authResult.user.uid}.jpg');
        // this returns a storage reference in firestore
        if (imageFile != null) {
          await reference.putFile(
              imageFile); // this code had .onComplete before. but in newer version of firebaseStorage it is no longer needed.
        }
        imageUrl = await reference.getDownloadURL();
// when imageUrl is 'none' just use Person_outlined icon
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user.uid)
            .set({
          'userName': userName,
          'email': email,
          'role': role,
          'imageUrl': imageUrl,
          'userId': authResult.user.uid,
          'pointsEarnedInTotal': 0,
        });
      }
    } on PlatformException catch (error) {
      setState(() {
        _isLoading = false;
      });
      var message = "Check your credentials please!";
      if (error.message != null) {
        message = error.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    } on FirebaseAuthException catch (error) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message),
        ),
      );
    }
  }

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
                        AuthForm(
                          isLoading: _isLoading,
                          submitData: _submitAuthForm,
                        ),
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
