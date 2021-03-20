import 'dart:math';
import 'dart:math' show Rectangle;
import 'package:charts_flutter/flutter.dart' as charts;
// ignore: implementation_imports
import 'package:charts_flutter/src/text_element.dart' as chartsTextElement;
// ignore: implementation_imports
import 'package:charts_flutter/src/text_style.dart' as chartsTextStyle;

import '../globals.dart';
import 'EmployeePerformance.dart';

// A dart file that consists of necessary components used in the making of the performance chart
List<charts.Series<EmployeePerformace, int>> createSampleData(
    List<EmployeePerformace> arr) {
  return [
    new charts.Series<EmployeePerformace, int>(
        id: 'Employee Points',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (EmployeePerformace emp, _) => emp.month,
        measureFn: (EmployeePerformace emp, _) => emp.points,
        fillColorFn: (_, __) => charts.MaterialPalette.teal.shadeDefault,
        data: arr,
        labelAccessorFn: (EmployeePerformace emp, _) =>
            emp.month.toString() + ", " + emp.points.toString())
  ];
}

class CustomCircleSymbolRenderer extends charts.CircleSymbolRenderer {
  static String x;
  CustomCircleSymbolRenderer();
  @override
  void paint(charts.ChartCanvas canvas, Rectangle<num> bounds,
      {List<int> dashPattern,
      charts.Color fillColor,
      charts.FillPatternType fillPattern,
      charts.Color strokeColor,
      double strokeWidthPx}) {
    super.paint(canvas, bounds,
        dashPattern: dashPattern,
        fillColor: charts.Color.white,
        strokeColor: charts.Color.black,
        strokeWidthPx: 1);

    // Draw a bubble

    final num bubbleHight = 35;
    final num bubbleWidth = 75;
    final num bubbleRadius = bubbleHight / 2.0;
    final num bubbleBoundLeft = bounds.left - 30;
    final num bubbleBoundTop = bounds.top - bubbleHight - 10;

    canvas.drawRRect(
      Rectangle(bubbleBoundLeft, bubbleBoundTop, bubbleWidth, bubbleHight),
      fill: charts.Color(r: 202, g: 206, b: 227),
      stroke: charts.Color.black,
      radius: bubbleRadius,
      roundTopLeft: true,
      roundBottomLeft: true,
      roundBottomRight: true,
      roundTopRight: true,
    );

    // Add text inside the bubble

    final textStyle = chartsTextStyle.TextStyle();
    textStyle.color = isDark ? charts.Color.white : charts.Color.black;
    textStyle.fontSize = 16;

    final chartsTextElement.TextElement textElement =
        chartsTextElement.TextElement(x.toString(), style: textStyle);

    final num textElementBoundsLeft = ((bounds.left -
            30 +
            (bubbleWidth - textElement.measurement.horizontalSliceWidth) / 2))
        .round();
    final num textElementBoundsTop = (bounds.top - 35).round();

    canvas.drawText(textElement, textElementBoundsLeft, textElementBoundsTop);
  }
}
