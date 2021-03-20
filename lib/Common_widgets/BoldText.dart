import 'package:flutter/material.dart';

// N will add this in Common widgets
class BoldText extends StatelessWidget {
  const BoldText({Key key, this.str}) : super(key: key);
  final String str;
  @override
  Widget build(BuildContext context) {
    return Text(
      str,
      style: TextStyle(
          color: Colors.black87, fontSize: 22, fontWeight: FontWeight.bold),
    );
  }
}
