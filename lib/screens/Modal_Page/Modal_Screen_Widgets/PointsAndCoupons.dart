import 'package:flutter/material.dart';

class PointsAndCoupons extends StatelessWidget {
  final Function changePoints;
  final TextEditingController ctr;
  const PointsAndCoupons({Key key, @required this.changePoints, this.ctr})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, top: 10, bottom: 10),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 90,
              width: 90,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFF7F3BE).withOpacity(0.6),
                      offset: Offset(-3.0, -3.0),
                      blurRadius: 3.0,
                    ),
                    BoxShadow(
                      color: Color(0xFF87813D).withOpacity(0.3),
                      offset: Offset(3.0, 3.0),
                      blurRadius: 3.0,
                    ),
                  ],
                  gradient: LinearGradient(colors: [
                    Color(0xFFffb700),
                    // Colors.yellow,
                    Color(0xFFFAF3AC)
                  ])),
              child: TextField(
                controller: ctr,
                keyboardType: TextInputType.number,
                cursorColor: Colors.black,
                textInputAction: TextInputAction.done,
                onChanged: (value) {
                  final val = int.parse(
                    value,
                  );
                  if (val != null) {
                    changePoints(val);
                  }
                },
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20, right: 25),
                    hintText: "Enter",
                    border: InputBorder.none),
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              height: 50,
              width: 50,
              padding: EdgeInsets.only(bottom: 3),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Color(0xFFf0f0f0),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFebebeb).withOpacity(0.5),
                      offset: Offset(-3.0, -3.0),
                      blurRadius: 3.0,
                    ),
                    BoxShadow(
                      color: Color(0xFF4A4A4A).withOpacity(0.1),
                      offset: Offset(3.0, 3.0),
                      blurRadius: 3.0,
                    ),
                  ]),
              child: Text("+",
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 26)),
            ),
          ],
        ),
      ),
    );
  }
}
