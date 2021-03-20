import 'package:flutter/material.dart';

class AssignButton extends StatelessWidget {
  final Function execute;
  const AssignButton({
    Key key,
    @required this.execute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        margin: EdgeInsets.all(25),
        width: w / 2,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Color(0xFF57C6FA),
            boxShadow: [
              BoxShadow(
                color: Color(0xFFD6F2FF).withOpacity(0.6),
                offset: Offset(-3.0, -3.0),
                blurRadius: 3.0,
              ),
              BoxShadow(
                color: Color(0xFF3E4F57).withOpacity(0.3),
                offset: Offset(3.0, 3.0),
                blurRadius: 3.0,
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            onTap: () {
              execute();
              Navigator.pop(context);
            },
            child: Container(
              margin: EdgeInsets.all(10),
              width: w / 2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              alignment: Alignment.center,
              child: Text(
                "Assign",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
