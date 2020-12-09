import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_constants.dart';

Widget customBoldText({
  String text = "",
  Color color = blackColor,
  double letterSpacing = 0.0,
}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontWeight: FontWeight.bold,
      fontSize: 20.w,
      letterSpacing: letterSpacing,
    ),
  );
}

Widget customNormalText({
  String text,
  Color color = whiteColor,
  double fontSize = 14.0,
}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontWeight: FontWeight.w500,
      fontSize: fontSize,
    ),
  );
}

Widget customThinText({
  String text,
  Color color = blackColor,
  double fontSize = 14.0,
}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontWeight: FontWeight.w400,
      fontSize: fontSize,
    ),
  );
}
