import 'package:flutter/material.dart';

import '../globals.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(5),
      color: textColor(),
      height: 0.5,
      width: width / 2,
    );
  }
}
