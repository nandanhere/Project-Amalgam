import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_amalgam/Common_widgets/CustomCircularProgressIndicator.dart';

import '../../../globals.dart';
import 'UserTile.dart';

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .orderBy('userName', descending: false)
          .snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.data == null) {
          return Center(
            child: CustomProgressIndicator(),
          );
        }

        List<DocumentSnapshot> chatDoc = snapshot.data.documents;
        return Center(
          child: UserSearchList(
            chatDoc: chatDoc,
          ),
        );
      },
    );
  }
}

class UserSearchList extends StatefulWidget {
  UserSearchList({Key key, this.chatDoc}) : super(key: key);
  final List<DocumentSnapshot> chatDoc;
  @override
  _UserSearchListState createState() => _UserSearchListState();
}

TextEditingController _searchQueryController = TextEditingController();
bool _searching = false;
List<DocumentSnapshot> temp;

class _UserSearchListState extends State<UserSearchList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          child: TextField(
            controller: _searchQueryController,
            autofocus: true,
            decoration: InputDecoration(
                hintText: "Search Data",
                hintStyle: TextStyle(color: Colors.black38),
                suffix: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _searchQueryController.clear();
                  },
                )),
            style: TextStyle(color: textColor(), fontSize: 16.0),
            onChanged: (query) {
              final s = query.trim().toLowerCase();
              if (s.isNotEmpty) {
                _searching = true;
                temp = widget.chatDoc.where((e) {
                  return e["userName"].toString().toLowerCase().contains(s) ||
                      e["role"].toString().toLowerCase().contains(s);
                }).toList();
                setState(() {});
              } else {
                _searching = false;
                temp.clear();
                setState(() {});
              }
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount:
                  (_searching == true) ? temp.length : widget.chatDoc.length,
              itemBuilder: (ctx, index) {
                return Container(
                  child: UserTile(
                    userDoc: (_searching == true)
                        ? temp[index]
                        : widget.chatDoc[index],
                  ),
                );
              }),
        ),
      ],
    );
  }
}
