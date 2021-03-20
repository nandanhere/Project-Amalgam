import 'package:flutter/material.dart';

class ButtonRow extends StatelessWidget {
  const ButtonRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, top: 0),
      child: Row(
        children: [
          DisplayIconButton(ic: Icons.calendar_today_outlined, onTap: () {}),
          SizedBox(
            width: 20,
          ),
          DisplayIconButton(ic: Icons.create, onTap: () {}),
          SizedBox(
            width: 20,
          ),
          DisplayIconButton(ic: Icons.local_post_office_outlined, onTap: () {}),
        ],
      ),
    );
  }
}

class DisplayIconButton extends StatelessWidget {
  const DisplayIconButton({Key key, @required this.ic, @required this.onTap})
      : super(key: key);
  final IconData ic;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: InkWell(
        onTap: onTap,
        child: Icon(
          ic,
          color: Colors.black,
          size: 22,
        ),
      ),
      radius: 20,
      backgroundColor: Colors.blueGrey[100],
    );
  }
}
