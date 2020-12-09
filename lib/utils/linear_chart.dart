import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_constants.dart';

dayForecastChart({List<String> temps, List times}) {
  return LineChartData(
    gridData: FlGridData(
      show: false,
    ),
    titlesData: FlTitlesData(
      show: true,
      bottomTitles: SideTitles(
        margin: 10.h,
        getTextStyles: (value) => TextStyle(
          color: greyColor03,
          fontSize: 14.w,
          fontWeight: FontWeight.w500,
        ),
        showTitles: true,
        getTitles: (value) {
          switch (value.toInt()) {
            case 0:
              return times[0];
            case 1:
              return times[1];
            case 2:
              return times[2];
            case 3:
              return times[3];
            case 4:
              return times[4];
            case 5:
              return times[5];
            case 6:
              return times[6];
            case 7:
              return times[7];
          }
          return '';
        },
      ),
      leftTitles: SideTitles(showTitles: false),
    ),
    borderData: FlBorderData(
      show: false,
    ),
    lineBarsData: [
      LineChartBarData(
        isCurved: false,
        show: true,
        colors: [blueGreyColor05, blueGreyColor02],
        barWidth: 2,
        spots: [
          FlSpot(0, double.parse(temps[0])),
          FlSpot(1, double.parse(temps[1])),
          FlSpot(2, double.parse(temps[2])),
          FlSpot(3, double.parse(temps[3])),
          FlSpot(4, double.parse(temps[4])),
          FlSpot(5, double.parse(temps[5])),
          FlSpot(6, double.parse(temps[6])),
          FlSpot(7, double.parse(temps[7])),
        ],
        dotData: FlDotData(
          show: true,
        ),
      ),
    ],
  );
}
