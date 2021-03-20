import 'package:flutter/material.dart';

class CompanyName extends StatelessWidget {
  const CompanyName({Key key, this.str}) : super(key: key);
  final String str;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15),
        child: Text(
          str,
          textAlign: TextAlign.start,
          style: TextStyle(
              color: Colors.black87, fontSize: 25, fontWeight: FontWeight.bold),
        ));
  }
}
