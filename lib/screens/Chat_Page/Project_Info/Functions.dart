import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_amalgam/Common_widgets/projectDetails.dart';

import 'HorizontalMemberList.dart';

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

Color statColor(String st) {
  switch (st.toUpperCase()) {
    case "ASSIGNED":
      return Colors.indigo;
    case "IN PROGRESS":
      return Colors.blue;
    case "DONE":
      return Colors.green;
    case "BACKLOG":
      return Colors.grey;
    case "REVIEW":
      return Colors.orange;
    case "TESTING":
      return Colors.purple;
    default:
      return Colors.black54;
  }
  // return Colors.black54;
}

Widget horizMemsRow(List<Member> members, double width) {
  print(members);
  List<Widget> list = [];
  // print(tmems.map((e) => e.name));
  for (int i = 0; i < members.length; i++) {
    list.add(MemberViewer(member: members[i]));
  }
  return Wrap(
    children: list,
    runAlignment: WrapAlignment.center,
    spacing: 10,
  );
}
