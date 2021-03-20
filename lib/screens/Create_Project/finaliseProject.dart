import 'package:flutter/material.dart';
import 'package:project_amalgam/Common_widgets/BoldText.dart';
import 'package:project_amalgam/Common_widgets/CustomDivider.dart';
import 'package:project_amalgam/screens/Home_Page/Home_Page.dart';

import '../../globals.dart';
import 'finalise_Project_Screen_Widgets/FinalList.dart';
import 'finalise_Project_Screen_Widgets/finaliseProjectHelperFunctions.dart';
import 'finalise_Project_Screen_Widgets/privateProjectSwitch.dart';

class FinaliseProjectScreen extends StatelessWidget {
  const FinaliseProjectScreen({Key key}) : super(key: key);
  static const routeName = "/finaliseProject";
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    String _projectName = "hidden_test_projectName";
    String _projectDesc = "hidden_test_projectDesc";
    bool _isPrivate = false;

    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;

    void changeBool(bool value) {
      _isPrivate = value;
    }

    return Scaffold(
      backgroundColor: darkMode(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: textColor()),
        title: Text(
          "Create The project",
          style: TextStyle(color: textColor()),
        ),
        backgroundColor: darkMode(),
        elevation: 2,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: IconButton(
              icon: Icon(Icons.check, color: Colors.black87),
              onPressed: () {
                HelperFunctions.finaliseProjectDetails(
                  _projectDesc,
                  _projectName,
                  _isPrivate,
                  args['list'],
                  args['data'],
                );
                Navigator.pushNamedAndRemoveUntil(
                    context, HomePage.routeName, (route) => false);
              },
              splashRadius: 25,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // color: Colors.blue,
              margin: EdgeInsets.only(top: 10),
              // height: height / 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(children: [
                        Container(
                          margin: const EdgeInsets.all(8.0),
                          height: 50,
                          width: width - 100,
                          child: TextField(
                            cursorColor: Colors.black,
                            textInputAction: TextInputAction.search,
                            onChanged: (val) {
                              _projectName = val.trim();
                            },
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(hintText: "Enter Name"),
                            style: TextStyle(fontSize: 18, color: textColor()),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(8.0),
                          height: 50,
                          width: width - 100,
                          child: TextField(
                            cursorColor: Colors.black,
                            textInputAction: TextInputAction.search,
                            onChanged: (val) {
                              _projectDesc = val.trim();
                            },
                            textAlign: TextAlign.start,
                            decoration:
                                InputDecoration(hintText: "Enter Description"),
                            style: TextStyle(fontSize: 18, color: textColor()),
                          ),
                        ),
                        PrivateProjectSwitch(
                          changeBool: changeBool,
                          width: width,
                        )
                      ]),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Add a project picture and a description for it",
                      style: TextStyle(color: textColor())),
                  SizedBox(
                    height: 10,
                  ),
                  CustomDivider()
                ],
              ),
            ),
            Row(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BoldText(
                  str: "Participants:",
                ),
              )
            ]),
            SizedBox(
              height: 10,
            ),
            FinalList(
              data: args['data'],
              list: args['list'],
            )
          ],
        ),
      ),
    );
  }
}
