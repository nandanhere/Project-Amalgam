import 'package:flutter/material.dart';
import 'package:project_amalgam/Common_widgets/SizeSpecifier.dart';

class ProjDescrip extends StatelessWidget {
  final String projectDesc;
  const ProjDescrip({
    Key key,
    @required this.projectDesc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
        margin: EdgeInsets.only(left: 25, top: 20, right: 0),
        padding: EdgeInsets.all(20),
        width: width,
        decoration: BoxDecoration(
            color: Color(0xFFFCE8BD),
            // gradient: LinearGradient(
            //   colors: [Color(0xFFF9E6AD), Color(0xFFE8BAA2)],
            // ),
            boxShadow: [
              BoxShadow(
                color: Color(0xFFdfdfdf).withOpacity(0.2),
                offset: Offset(-3.0, -3.0),
                blurRadius: 3.0,
              ),
              BoxShadow(
                color: Color(0xFF000000).withOpacity(0.1),
                offset: Offset(3.0, 3.0),
                blurRadius: 3.0,
              ),
            ],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), bottomLeft: Radius.circular(50))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Overview",
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              projectDesc,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: returner(widthdecider(width), 15, 18, 18),
              ),
              maxLines: 10,
              softWrap: true,
            )
          ],
        ));
  }
}
