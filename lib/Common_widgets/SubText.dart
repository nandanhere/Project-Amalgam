import 'package:flutter/material.dart';

class SubText extends StatelessWidget {
  const SubText({Key key, this.str}) : super(key: key);
  final String str;
  @override
  Widget build(BuildContext context) {
    return Text(
      str,
      textAlign: TextAlign.start,
      style: TextStyle(
          color: Colors.purple, fontSize: 15, fontWeight: FontWeight.bold),
    );
  }
}
