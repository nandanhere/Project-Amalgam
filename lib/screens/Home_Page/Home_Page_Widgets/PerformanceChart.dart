import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:project_amalgam/Common_widgets/chart_funcs.dart';

class PerformanceChart extends StatelessWidget {
  const PerformanceChart({
    Key key,
    @required this.series,
  }) : super(key: key);

  final List<charts.Series> series;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.all(5),
      height: height / 3.5 < 250 ? height / 3.5 : 250,
      width: width / 1.5,
      decoration: BoxDecoration(
          color: Color(0xFFE0E0E0),
          // border: Border(),
          boxShadow: [
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
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20))),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 15, top: 15),
            child: Text(
              "Performance",
              style: TextStyle(fontSize: 20),
            ),
            alignment: Alignment.centerLeft,
          ),
          Flexible(
            child: Container(
                margin: EdgeInsets.only(left: 5),
                alignment: Alignment.bottomCenter,
                height: height / 3.5 < 250 ? (height / 3.5) - 50 : 200,
                width: width / 1.52,
                child: new charts.LineChart(
                  series,
                  animate: true,
                  selectionModels: [
                    charts.SelectionModelConfig(
                        changedListener: (charts.SelectionModel model) {
                      String str1, str2;
                      if (model.hasDatumSelection)
                        str1 = model.selectedSeries[0]
                            .domainFn(model.selectedDatum[0].index)
                            .toString();
                      str2 = model.selectedSeries[0]
                          .measureFn(model.selectedDatum[0].index)
                          .toString();
                      CustomCircleSymbolRenderer.x = str1 + " , " + str2;
                    })
                  ],
                  behaviors: [
                    charts.LinePointHighlighter(
                        symbolRenderer: CustomCircleSymbolRenderer()),
                  ],
                  animationDuration: Duration(seconds: 1),
                  defaultRenderer: new charts.LineRendererConfig(
                    includePoints: true,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
