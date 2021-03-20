import 'dart:io';
//N will do this half way
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../../globals.dart';

class UserInfoScreen extends StatelessWidget {
  static const routeName = "/UserInfoScreen";

  const UserInfoScreen({Key key}) : super(key: key);
  Future<dynamic> function() async {
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(userIdGlobal)
        .get();
    return userData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Details"),
      ),
      body: FutureBuilder(
        future: function(),
        builder: (ctx, snap) {
          return snap.data == null
              ? Center(child: CircularProgressIndicator())
              : Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        snap.data['userName'],
                        style: TextStyle(fontSize: 30),
                      ),
                      UserImageUpdater(userData: snap.data),
                      Text(
                        snap.data['pointsEarnedInTotal'].toString(),
                        style: TextStyle(fontSize: 30),
                      ),
                      Text(
                        snap.data['pointsEarnedInTotal'].toString(),
                        style: TextStyle(fontSize: 30),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}

class UserImageUpdater extends StatefulWidget {
  final dynamic userData;
  UserImageUpdater({Key key, this.userData}) : super(key: key);

  @override
  _UserImageUpdaterState createState() => _UserImageUpdaterState();
}

class _UserImageUpdaterState extends State<UserImageUpdater> {
  File _pickedImage;

  void _changeUserImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 50, maxWidth: 150);
    final imageFile = File(pickedImage.path);
    setState(() {
      _pickedImage = imageFile;
    });
    final reference = FirebaseStorage.instance.ref().child('userImages').child(
        '$userIdGlobal.jpg'); // this returns a storage reference in firestore
    await reference.putFile(imageFile);

    final imageUrl = await reference.getDownloadURL();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userData['userId'])
        .update({'imageUrl': imageUrl});

    Fluttertoast.showToast(msg: "Restart App to view changes");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundImage: _pickedImage == null
              ? widget.userData == null
                  ? AssetImage("assets/amalgam_logo.png")
                  : NetworkImage(widget.userData['imageUrl'])
              : FileImage(_pickedImage),
        ),
        TextButton.icon(
          onPressed: _changeUserImage,
          icon: Icon(Icons.image),
          label: Text("Change Profile Image"),
          style: TextButton.styleFrom(
              textStyle: TextStyle(
            color: Theme.of(context).primaryColor,
          )),
        ),
      ],
    );
  }
}
