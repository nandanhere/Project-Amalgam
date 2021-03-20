import 'package:flutter/material.dart';

class DescripBox extends StatelessWidget {
  final Function changeTaskDesc;
  final TextEditingController ctr;
  const DescripBox({Key key, @required this.changeTaskDesc, this.ctr})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(
          left: 15.0,
          right: 15,
        ),
        alignment: Alignment.topCenter,
        color: Color(0xFFE0E0E0),
        child: TextField(
          controller: ctr,
          onChanged: (value) {
            changeTaskDesc(value.trim());
          },
          maxLines: 5,
          cursorColor: Colors.black,
          decoration: InputDecoration(
              isCollapsed: false,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black54, width: 1.0),
              ),
              hintText: "Enter your text here"),
        ));
  }
}
