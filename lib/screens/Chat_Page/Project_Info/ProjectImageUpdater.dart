import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProjectImageUpdater extends StatefulWidget {
  final bool canUpdate;
  final String projectId;
  final String imageUrl;
  ProjectImageUpdater(
      {Key key,
      @required this.canUpdate,
      @required this.projectId,
      @required this.imageUrl})
      : super(key: key);

  @override
  _ProjectImageUpdaterState createState() => _ProjectImageUpdaterState();
}

class _ProjectImageUpdaterState extends State<ProjectImageUpdater> {
  File _pickedImage;
  void _changeProjectImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 50, maxWidth: 150);
    final imageFile = File(pickedImage.path);
    setState(() {
      _pickedImage = imageFile;
    });
    final reference = FirebaseStorage.instance.ref().child('projectIcons').child(
        '${widget.projectId}.jpg'); // this returns a storage reference in firestore
    await reference.putFile(imageFile);

    final imageUrl = await reference.getDownloadURL();
    await FirebaseFirestore.instance
        .collection('projects')
        .doc(widget.projectId)
        .update({'imageUrl': imageUrl});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          child: CircleAvatar(
            radius: 40,
            backgroundImage: _pickedImage == null
                ? widget.imageUrl == null
                    ? AssetImage("assets/amalgam_logo.png")
                    : NetworkImage(widget.imageUrl)
                : FileImage(_pickedImage),
          ),
          onTap: _changeProjectImage,
        ),
      ],
    );
  }
}
