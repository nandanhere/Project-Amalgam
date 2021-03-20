import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_amalgam/Common_widgets/SizeSpecifier.dart';

class OpenProjects extends StatelessWidget {
  const OpenProjects({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print(height / 3.5);
    DeviceType type = widthdecider(width);
    return Container(
      margin: EdgeInsets.all(5),
      height: height / 3.5 < 250 ? height / 3.5 : 250,
      width: width / 3.5 < 200 ? width / 3.5 + 20 : 200,
      decoration: BoxDecoration(
          color: Color(0xFFCBDCF2),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFDCE8F7).withOpacity(0.5),
              offset: Offset(-3.0, -3.0),
              blurRadius: 3.0,
            ),
            BoxShadow(
              color: Color(0xFF7B818A).withOpacity(0.2),
              offset: Offset(3.0, 3.0),
              blurRadius: 3.0,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          onTap: () {},
          child: Text(
            "Join Any Open Project For Free  ",
            style: GoogleFonts.bangers(fontSize: 20),
            textAlign: TextAlign.right,
          ),
        ),
      ),
    );
  }
}
