import 'package:flutter/material.dart';

class DeadlineElements extends StatefulWidget {
  final Function changeDeadLine;

  const DeadlineElements({Key key, @required this.changeDeadLine})
      : super(key: key);
  @override
  _DeadlineElementsState createState() => _DeadlineElementsState();
}

String dateTeller(DateTime date) {
  List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
  String st = "";
  st += date.day.toString();
  st += " ";
  st += months[date.month - 1];
  st += " ";
  st += date.year.toString();
  return st;
}

class _DeadlineElementsState extends State<DeadlineElements> {
  bool today = true, tommo = false, other = false;
  DateTime _selectedDate = DateTime.now();
  void toggle(String t) {
    if (t == "today") {
      today = true;
      tommo = false;
      other = false;
    } else if (t == "tommo") {
      today = false;
      tommo = true;
      other = false;
    } else {
      today = false;
      tommo = false;
      other = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Row(children: [
          InkWell(
            onTap: () {
              _selectedDate = DateTime.now();
              toggle("today");
              widget.changeDeadLine(_selectedDate);
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: (today == true) ? Colors.grey[400] : Color(0xFFf0f0f0),
                  boxShadow: (today == true)
                      ? [
                          BoxShadow(
                              offset: Offset(3, 3),
                              blurRadius: 3,
                              color: Colors.grey.withOpacity(0.3))
                        ]
                      : [
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
                        ],
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Text("Today"),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: () {
              DateTime now = DateTime.now();
              _selectedDate = DateTime(now.year, now.month, now.day + 1);
              toggle("tommo");
              widget.changeDeadLine(_selectedDate);
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: (tommo == true) ? Colors.grey[400] : Color(0xFFf0f0f0),
                  boxShadow: (tommo == true)
                      ? [
                          BoxShadow(
                              offset: Offset(3, 3),
                              blurRadius: 3,
                              color: Colors.grey.withOpacity(0.3))
                        ]
                      : [
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
                        ],
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Text("Tomorrow"),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: () {
              showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(DateTime.now().year + 50))
                  .then((pickedDate) {
                if (pickedDate == null) {
                  return;
                }
                toggle("other");
                setState(() {
                  _selectedDate = pickedDate;
                  widget.changeDeadLine(pickedDate);
                });
              });
            },
            child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color:
                        (other == true) ? Colors.grey[400] : Color(0xFFf0f0f0),
                    boxShadow: (other == true)
                        ? [
                            BoxShadow(
                                offset: Offset(3, 3),
                                blurRadius: 3,
                                color: Colors.grey.withOpacity(0.3))
                          ]
                        : [
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
                          ],
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Wrap(
                    alignment: WrapAlignment.center,
                    runAlignment: WrapAlignment.center,
                    spacing: 10,
                    children: [
                      Text(
                        dateTeller(_selectedDate),
                      ),
                      Icon(Icons.calendar_today_outlined, size: 16)
                    ])),
          )
        ]),
      ),
    );
  }
}
