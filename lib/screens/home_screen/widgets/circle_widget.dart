import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartWidget extends StatelessWidget {
  final Map<String, double> titleTotals;
  final double containerWidth;
  final double containerHeight;
  final double minBarHeight;
  final double maxBarHeight;
  final double barWidth;
  final List<Color> colorPalette;
  final double padding;

  const BarChartWidget({
    Key? key,
    required this.titleTotals,
    this.containerWidth = 250.0,
    this.containerHeight = 210.0,
    this.minBarHeight = 50.0,
    this.maxBarHeight = 150.0,
    this.barWidth = 40.0,
    this.padding = 5.0,
    this.colorPalette = const [
      Color(0xFFD6CCFB), // Light purple
      Color(0xFFFFD9A7), // Light orange
      Color(0xFFBEF0CA), // Light green
      Color(0xFFB7E8FF), // Light blue
    ],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double maxAmount = titleTotals.values.isNotEmpty
        ? titleTotals.values.reduce((a, b) => a > b ? a : b)
        : 1;

    final List<BarChartGroupData> barGroups = [];
    final List<String> labels = [];

    int index = 0;
    titleTotals.forEach((title, value) {
      double barHeight =
          (value / maxAmount) * (maxBarHeight - minBarHeight) + minBarHeight;
      labels.add(title);

      barGroups.add(
        BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: barHeight,
              width: barWidth,
              borderRadius: BorderRadius.circular(10),
              color: colorPalette[index % colorPalette.length],
            ),
          ],
        ),
      );

      index++;
    });

    return SizedBox(
      width: containerWidth,
      height: containerHeight,
      child: BarChart(
        BarChartData(
          barGroups: barGroups,
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final label = labels[value.toInt()];
                  return Text(label, style: TextStyle(fontSize: 12));
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }
}
