import 'package:flutter/material.dart';
import 'package:project_amalgam/Providers/UsersSelectedProvider.dart';
import 'package:provider/provider.dart';
import 'Select_Members_Screen_Widgets/UserList.dart';
import 'finaliseProject.dart';

class SelectMembersScreen extends StatelessWidget {
  static const routeName = "/selectMember";
  const SelectMembersScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListenableProvider<UsersSelected>(
      create: (_) {
        return UsersSelected();
      },
      child: UserList(),
      builder: (context, child) {
        return Scaffold(
          backgroundColor: Color(0xFFE0E0E0),
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black87),
            backgroundColor: Color(0xFFE0E0E0),
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            title: Column(
              children: [
                FittedBox(
                  child: Text(
                    "Select members",
                    style: TextStyle(color: Colors.black87),
                  ),
                ),
                FittedBox(
                  child: Text(
                    "${Provider.of<UsersSelected>(context).count} out of 10 selected ",
                    style: TextStyle(fontSize: 12, color: Colors.black87),
                  ),
                )
              ],
            ),
            actions: [
              IconButton(
                  icon: Icon(Icons.arrow_forward, color: Colors.black87),
                  onPressed: () {
                    final list =
                        Provider.of<UsersSelected>(context, listen: false)
                            .selectedMembers;
                    final data =
                        Provider.of<UsersSelected>(context, listen: false)
                            .memberData;
                    Navigator.pushNamed(
                        context, FinaliseProjectScreen.routeName,
                        arguments: {"list": list, "data": data});
                  })
            ],
          ),
          body: child,
        );
      },
    );
  }
}
