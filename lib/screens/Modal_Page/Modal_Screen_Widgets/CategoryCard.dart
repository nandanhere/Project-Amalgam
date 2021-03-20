import 'package:flutter/material.dart';

List<String> textCache = [""];

class CategoryCard extends StatelessWidget {
  CategoryCard({Key key, this.suffwid, this.color, this.ctr}) : super(key: key);
  final Widget suffwid;
  final Color color;
  final TextEditingController ctr;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [color.withAlpha(100), color]),
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
                blurRadius: 3,
                spreadRadius: 2,
                offset: Offset(2, 4),
                color: Color(0xFFd1d1d1))
          ]),
      height: 48,
      // width: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            child: TextField(
              controller: ctr,
              cursorColor: Colors.black,
              textInputAction: TextInputAction.search,
              onChanged: (val) {
                textCache[textCache.length - 1] = val;
              },
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  hintText: "Category", border: InputBorder.none),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: suffwid,
          )
        ],
      ),
    );
  }
}
