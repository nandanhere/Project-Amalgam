import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// A class created for the importing of required photos by the user using gallery of their device
class UserImagePicker extends StatefulWidget {
  final Function(File pickedImage) imagePickFn;

  const UserImagePicker({Key key, this.imagePickFn}) : super(key: key);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage;
  void _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 10, maxWidth: 150);
    final imageFile = File(pickedImage.path);
    setState(() {
      _pickedImage = imageFile;
    });
    widget.imagePickFn(imageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          child: _pickedImage == null
              ? Icon(
                  Icons.person,
                )
              : null,
          radius: 40,
          backgroundImage:
              _pickedImage == null ? null : FileImage(_pickedImage),
        ),
        TextButton.icon(
          style: TextButton.styleFrom(
            textStyle: TextStyle(color: Theme.of(context).primaryColor),
          ),
          onPressed: _pickImage,
          icon: Icon(Icons.image),
          label: Text("Add profile Image"),
        ),
      ],
    );
  }
}
