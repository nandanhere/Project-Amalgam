import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_amalgam/Common_widgets/SizeSpecifier.dart';

import 'PercentIndicator.dart';

class StatsInfo extends StatelessWidget {
  const StatsInfo({
    Key key,
    @required this.role,
  }) : super(key: key);

  final String role;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(20),
      height: returner(widthdecider(width), 150, 200, 200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Color(0xFF8C76DE),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFD0CAE6).withOpacity(0.5),
            offset: Offset(-3.0, -3.0),
            blurRadius: 3.0,
          ),
          BoxShadow(
            color: Color(0xFF5D596E).withOpacity(0.5),
            offset: Offset(3.0, 3.0),
            blurRadius: 3.0,
          ),
        ],
      ),
      child: Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(right: 0, top: 10),
            child: Text(
              "Johnathan Doesmith" + " | " + role,
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: returner(widthdecider(width), 15, 17, 17)),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                PercentIndicator(
                  value: 70,
                  barColor: [Colors.blue, Colors.tealAccent],
                  title: "Project Completed",
                ),
                PercentIndicator(
                  value: 64,
                  barColor: [Colors.green[600], Colors.teal[300]],
                  title: "Tasks Completed",
                ),
                PercentIndicator(
                  value: 90,
                  barColor: [Colors.amber, Colors.purpleAccent],
                  title: "Successful Submissions",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
