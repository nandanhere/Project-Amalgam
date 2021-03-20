import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FinalList extends StatelessWidget {
  final List<String> list;
  final Map<String, DocumentSnapshot> data;
  const FinalList({Key key, this.list, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 15,
      runSpacing: 10,
      children: list.map((e) {
        final user = data[e];
        final name = user['userName'];
        return Column(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(user['imageUrl']),
            ),
            SizedBox(height: 2),
            Text(name),
            SizedBox(height: 2),
            Text("CEO"),
          ],
        );
      }).toList(),
    );
  }
}
