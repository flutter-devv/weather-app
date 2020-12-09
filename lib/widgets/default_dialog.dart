import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/constants/app_constants.dart';

Future<void> customDialog({
  String content = "",
  String confirmText = "",
  GestureTapCallback onPressed,
}) {
  Get.defaultDialog(
    title: "Oops",
    titleStyle: TextStyle(color: redColor),
    content: Text(content),
    confirm: FlatButton(
      onPressed: () => onPressed,
      child: Text(confirmText),
      textColor: blueColor05,
    ),
    barrierDismissible: false,
  );
}
