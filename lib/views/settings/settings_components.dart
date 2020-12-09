import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weather_app/constants/app_constants.dart';
import 'package:weather_app/controllers/settings_controller.dart';
import 'package:weather_app/widgets/custom_text.dart';

final controller = Get.find<SettingsController>();
GetStorage box = GetStorage();
List<String> notificationTimes = [
  "never",
  "1 hour",
  "3 hours",
  "6 hours",
  "12 hour",
  "24 hour",
];

// this for notification & unit bloc
Widget settingBloc({
  Widget child,
}) {
  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: 10.w,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(6.0),
      color: greyColor02,
    ),
    child: child,
  );
}

Widget settingItem({
  String text,
  Widget widget,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      customThinText(
        text: text,
      ),
      widget
    ],
  );
}

Widget notificationSwitch() {
  return Switch(
    value: controller.notificationSwitch.value,
    onChanged: (bool val) {
      // change switch state
      controller.changeNotificationSwitchState(val);
      // save the state into GetStorage
      box.write(
        "switchState",
        controller.notificationSwitch.value,
      );
    },
  );
}

Widget customRadio(
  int index,
) {
  return Radio(
      value: index,
      groupValue: controller.groupValue.value,
      onChanged: (int val) {
        // change radio state
        controller.changeGroupValueState(val);
        // save the state into GetStorage
        box.write(
          "radioState",
          controller.groupValue.value,
        );
      });
}

Widget notificationTimeButton() {
  return FlatButton(
    onPressed: () => Get.defaultDialog(
      title: "Select after how many hours you need to receive notification",
      titleStyle: TextStyle(
        color: blueColor05,
      ),
      content: Container(
        height: 240.h,
        width: Get.width,
        child: ListView.builder(
          itemCount: notificationTimes.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              height: 40.h,
              child: InkWell(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    notificationTimes[index],
                  ),
                ),
                onTap: () {
                  // change notification time
                  controller.changeNotificationTime(
                    notificationTimes[index],
                  );
                  // save the time into GetStorage
                  box.write(
                    "notificationTime",
                    controller.selectedNotificationTime.value,
                  );
                  // close dialog
                  Get.close(1);
                },
              ),
            );
          },
        ),
      ),
    ),
    child: customThinText(
      text: controller.selectedNotificationTime.value,
      fontSize: 13.w,
    ),
    minWidth: 60.w,
    color: blueColor05.withOpacity(0.1),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
    ),
  );
}

// screen appBar
Widget getAppBar = AppBar(
  backgroundColor: transparentColor,
  title: Text(
    "Settings",
    style: TextStyle(
      color: blackColor,
    ),
  ),
  centerTitle: true,
  leading: IconButton(
    icon: Icon(
      Icons.arrow_back,
      color: blackColor,
    ),
    onPressed: () => Get.back(),
  ),
  elevation: 0.0,
);
