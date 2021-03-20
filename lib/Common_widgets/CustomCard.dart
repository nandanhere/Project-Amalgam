import 'package:flutter/material.dart';
import 'package:project_amalgam/Common_widgets/projectDetails.dart';
import 'package:project_amalgam/screens/Join_Public_Screen/ProjectPreview.dart';

import 'SizeSpecifier.dart';
// A class dealing with the creation the task display card

class CustomCard extends StatelessWidget {
  final bool isOpen;
  const CustomCard({
    Key key,
    @required this.details,
    @required this.isOpen,
  }) : super(key: key);
  final ProjectDetails details;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFBBE0A8),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFD1F0C2).withOpacity(0.5),
            offset: Offset(-3.0, -3.0),
            blurRadius: 3.0,
          ),
          BoxShadow(
            color: Color(0xFF697861).withOpacity(0.2),
            offset: Offset(3.0, 3.0),
            blurRadius: 3.0,
          ),
        ],
      ),
      margin: EdgeInsets.all(8),
      height: height / 5 < 200 ? height / 5 : 200,
      width: (width >= 720) ? width / 2.1 : width,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    details.title,
                    style: TextStyle(fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        if (details.categories.length >= 1)
                          Container(
                            padding: EdgeInsets.only(left: 5, right: 5),
                            alignment: Alignment.center,
                            height: 20,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              border: Border.all(
                                  color: Colors.pink[300], width: 1.5),
                            ),
                            child: Text(
                              details.categories.first,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        SizedBox(
                          width: 5,
                        ),
                        if (details.categories.length > 1)
                          Container(
                            padding: EdgeInsets.only(left: 5, right: 5),
                            alignment: Alignment.center,
                            height: 20,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              border: Border.all(
                                  color: Colors.pink[300], width: 1.5),
                            ),
                            child: Text(
                              details.categories.last,
                              textAlign: TextAlign.center,
                            ),
                          ),
                      ],
                    ),
                  ),
                  (height / 5 >= 135)
                      ? Padding(
                          padding: const EdgeInsets.only(left: 0.0, top: 5),
                          child: Text(
                            details.description,
                            maxLines: ((height ~/ 5) - 100) ~/ 20,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize:
                                    returner(widthdecider(width), 14, 15, 13)),
                          ))
                      : Text(details.description),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0, top: 10),
              child: Icon(
                Icons.more_horiz,
                size: 32,
              ),
            ),
          ),
          if (height / 5 < 135)
            Padding(
              padding: const EdgeInsets.only(right: 10.0, top: 10),
              child: Align(
                child: Text(
                  "Tap to view, Long Press for more info",
                  style: TextStyle(fontSize: 11, color: Colors.grey[800]),
                ),
                alignment: Alignment.centerRight,
              ),
            ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, bottom: 10),
              child: BottomNumberBar(details: details),
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                onTap: isOpen
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProjectPreview(
                              projectId: details.id,
                              projectName: details.title,
                              projectDesc: details.description,
                              imageUrl: details.imageUrl,
                            ),
                          ),
                        );
                      }
                    : () {},
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BottomNumberBar extends StatelessWidget {
  const BottomNumberBar({
    Key key,
    @required this.details,
  }) : super(key: key);

  final ProjectDetails details;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.history_toggle_off,
          color: Colors.grey[600],
          size: 20,
        ),
        SizedBox(
          width: 2,
        ),
        Text(
          dateToString(details.deadLine),
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
        SizedBox(
          width: 20,
        ),
        Icon(
          Icons.done_all_outlined,
          color: Colors.blue[300],
          size: 20,
        ),
        SizedBox(
          width: 2,
        ),
        Text(
          details.tasksDone.toString(),
          style: TextStyle(fontSize: 16, color: Colors.blue[300]),
        ),
        SizedBox(
          width: 20,
        ),
        Icon(
          Icons.mark_chat_unread_outlined,
          color: Colors.red[600],
          size: 20,
        ),
        SizedBox(
          width: 20,
        ),
        Icon(
          Icons.local_florist_outlined,
          color: Colors.yellow[900],
          size: 20,
        ),
        SizedBox(
          width: 2,
        ),
        Text(
          details.points.toString(),
          style: TextStyle(fontSize: 16, color: Colors.yellow[900]),
        ),
      ],
    );
  }
}

String dateToString(DateTime date) {
  String st = "";
  st += date.day.toString() + "/";
  st += date.month.toString() + "/";
  st += date.year.toString();
  return st;
}
