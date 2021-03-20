import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_amalgam/Providers/UsersSelectedProvider.dart';
import 'package:provider/provider.dart';
import '../../../globals.dart';

class UserTile extends StatefulWidget {
  UserTile({Key key, this.userDoc}) : super(key: key);
  final DocumentSnapshot userDoc;

  @override
  _UserTileState createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  @override
  Widget build(BuildContext context) {
    final userDocLocal = widget.userDoc;
    final name = userDocLocal['userName'];
    final role = userDocLocal['role'];
    final email = userDocLocal['email'];
    final userId = userDocLocal['userId'];
    if (userId != userIdGlobal)
      return Container(
        margin: EdgeInsets.only(top: 5, left: 5, right: 5),
        child: ListTile(
          tileColor: Provider.of<UsersSelected>(context, listen: false)
                  .isPresent(userId)
              ? Colors.lightGreen.withAlpha(50)
              : Theme.of(context).scaffoldBackgroundColor,
          onTap: () {
            setState(() {
              if (Provider.of<UsersSelected>(context, listen: false)
                  .isPresent(userId)) {
                Provider.of<UsersSelected>(context, listen: false)
                    .delete(userId);
              } else if (!Provider.of<UsersSelected>(context, listen: false)
                  .isPresent(userId)) {
                Provider.of<UsersSelected>(context, listen: false)
                    .add(userId, userDocLocal);
              }
            });
          },
          leading: CircleAvatar(
            backgroundImage: NetworkImage(widget.userDoc['imageUrl']),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
          title: Text(name + " | " + role),
          subtitle: Text(email),
        ),
      );
    else {
      return Container();
    }
  }
}
