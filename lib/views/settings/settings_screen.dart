import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/constants/app_constants.dart';
import 'package:weather_app/controllers/settings_controller.dart';
import 'package:weather_app/widgets/custom_text.dart';
import 'settings_components.dart';

class SettingsScreen extends StatelessWidget {
  final controller = Get.put(SettingsController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: getAppBar,
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40.h,
              ),
              // notification bloc
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customBoldText(
                    text: "Notification",
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  settingBloc(
                    child: Column(
                      children: [
                        settingItem(
                          text: "Weather notification",
                          widget: notificationSwitch(),
                        ),
                        settingItem(
                          text: "Send every:",
                          widget: notificationTimeButton(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              // unit bloc
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customBoldText(
                    text: "Unit",
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  settingBloc(
                    child: Column(
                      children: [
                        settingItem(
                          text: "Celsius",
                          widget: customRadio(0),
                        ),
                        settingItem(
                          text: "Fahrenheit",
                          widget: customRadio(1),
                        ),
                        settingItem(
                          text: "Kelvin",
                          widget: customRadio(2),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
