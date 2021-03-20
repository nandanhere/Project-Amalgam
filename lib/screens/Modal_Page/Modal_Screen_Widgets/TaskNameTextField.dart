import 'package:flutter/material.dart';

class TaskNameTextField extends StatelessWidget {
  final Function changeTaskName;
  final TextEditingController ctr;
  const TaskNameTextField({Key key, this.changeTaskName, this.ctr})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15.0),
      margin: EdgeInsets.only(left: 15, right: 15, top: 5),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(blurRadius: 3, spreadRadius: 3, color: Color(0xFFDEDEDE))
          ]),
      height: 48,
      width: MediaQuery.of(context).size.width - 10,
      child: TextField(
        controller: ctr,
        cursorColor: Colors.black,
        textInputAction: TextInputAction.search,
        onChanged: (change) {
          changeTaskName(change.trim());
        },
        textAlign: TextAlign.start,
        decoration:
            InputDecoration(hintText: "Enter Task", border: InputBorder.none),
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
