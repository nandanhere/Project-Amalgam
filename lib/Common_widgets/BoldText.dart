import 'package:flutter/material.dart';

import '../globals.dart';

class BoldText extends StatelessWidget {
  const BoldText({Key key, this.str}) : super(key: key);
  final String str;
  @override
  Widget build(BuildContext context) {
    return Text(
      str,
      style: TextStyle(
          color: textColor(), fontSize: 22, fontWeight: FontWeight.bold),
    );
  }
}
