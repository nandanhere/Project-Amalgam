import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_amalgam/Common_widgets/CustomDivider.dart';
import 'package:project_amalgam/Common_widgets/EmployeePerformance.dart';
import 'package:project_amalgam/Common_widgets/SizeSpecifier.dart';
import 'package:project_amalgam/Common_widgets/chart_funcs.dart';
import 'package:project_amalgam/Common_widgets/showProjects.dart';
import 'package:project_amalgam/screens/Create_Project/selectMembersScreen.dart';
import 'package:project_amalgam/screens/Settings_Page/settings_page.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../../globals.dart';
import 'Home_Page_Widgets/OpenProject.dart';
import 'Home_Page_Widgets/PerformanceChart.dart';
import 'Home_Page_Widgets/ProfileCard.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/HomePage';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    setGlobaluserId(FirebaseAuth.instance.currentUser.uid);
    print(width);
    // this is all dummy data we need to intitalise with real data
    DeviceType type = widthdecider(width);
    final arr = [
      new EmployeePerformace(0, 0),
      new EmployeePerformace(1, 60),
      new EmployeePerformace(2, 85),
      new EmployeePerformace(3, 97),
      new EmployeePerformace(4, 77),
      new EmployeePerformace(5, 99),
      new EmployeePerformace(6, 150),
      new EmployeePerformace(7, 220),
      new EmployeePerformace(8, 175),
      new EmployeePerformace(9, 154),
      new EmployeePerformace(10, 127),
      new EmployeePerformace(11, 137),
      new EmployeePerformace(12, 155),
    ];
    final List<charts.Series> series = createSampleData(arr);
    print(darkMode());
    return Scaffold(
      backgroundColor: darkMode(),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: FittedBox(
          child: Text(
            "Amalgam | Your company name here",
            style: TextStyle(color: textColor()),
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.settings, color: textColor()),
              onPressed: () {
                Navigator.pushNamed(context, SettingsPage.routeName);
              }),
          SizedBox(width: 10),
        ],
        centerTitle: false,
        backgroundColor: darkMode(),
        elevation: 2,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: ListView(
          // shrinkWrap: true
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FutureProfileCard(
                    type: type,
                  ),
                  PerformanceChart(series: series),
                  OpenProjects(),
                ],
              ),
            ),
            Center(child: CustomDivider()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 5.0),
                  child: Text(
                    "Projects",
                    style: TextStyle(fontSize: 24, color: textColor()),
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.shuffle,
                        color: textColor(),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.point_of_sale,
                        color: textColor(),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      IconButton(
                        iconSize: 32,
                        splashRadius: 25,
                        icon: Icon(Icons.group_add, color: textColor()),
                        onPressed: () {
                          Navigator.pushNamed(
                              context, SelectMembersScreen.routeName);
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
            ShowProjects(
              showPublic: false,
            ),
          ],
        ),
      ),
    );
  }
}
