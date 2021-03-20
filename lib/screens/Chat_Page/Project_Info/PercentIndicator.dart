import 'package:flutter/material.dart';
import 'package:project_amalgam/Common_widgets/SizeSpecifier.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PercentIndicator extends StatelessWidget {
  const PercentIndicator({Key key, this.value, this.barColor, this.title})
      : super(key: key);
  final int value;
  final List<Color> barColor;
  final String title;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return FittedBox(
      child: CircularPercentIndicator(
        radius: returner(widthdecider(width), 90, 130, 130),
        percent: value / 100,
        animation: true,
        // progressColor: barColor,
        linearGradient: LinearGradient(colors: barColor),
        center: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: value.toString(),
                      style: TextStyle(
                          color: Colors.grey[300],
                          fontSize: returner(widthdecider(width), 24, 34, 34))),
                  WidgetSpan(
                    child: Transform.translate(
                      offset: Offset(
                          2, returner(widthdecider(width), -15, -25, -25)),
                      child: Text(
                        '%',
                        textScaleFactor: 0.9,
                        style: TextStyle(color: Colors.grey[300]),
                      ),
                    ),
                  )
                ]),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: returner(widthdecider(width), 9, 14, 14),
                    color: Colors.grey[300]),
              ),
            ),
          ],
        ),
        animationDuration: 1000,
      ),
    );
  }
}
