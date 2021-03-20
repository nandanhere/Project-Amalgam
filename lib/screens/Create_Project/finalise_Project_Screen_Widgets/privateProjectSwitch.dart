import 'package:flutter/material.dart';

class PrivateProjectSwitch extends StatefulWidget {
  final Function(bool value) changeBool;
  final double width;
  PrivateProjectSwitch({Key key, this.width, this.changeBool})
      : super(key: key);

  @override
  _PrivateProjectSwitchState createState() => _PrivateProjectSwitchState();
}

class _PrivateProjectSwitchState extends State<PrivateProjectSwitch> {
  bool switchValue = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: widget.width - 100,
      child: Row(
        children: [
          Text("Make Project Private"),
          Switch.adaptive(
              value: switchValue,
              onChanged: (value) {
                setState(() {
                  switchValue = value;
                });
                widget.changeBool(value);
              })
        ],
      ),
    );
  }
}
