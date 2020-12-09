import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:get/get.dart';
import 'package:weather_app/config/routes.dart';
import 'package:weather_app/views/home/home_screen.dart';
import 'package:weather_app/views/settings/settings_screen.dart';

// app sizes
extension screenWidth on int {
  double get w => ScreenUtil().setWidth(this);
  double get h => ScreenUtil().setHeight(this);
}

// app colors
const Color blackColor = Color(0xff000000);
const Color whiteColor = Color(0xffFFFFFF);
const Color splashBlueColor01 = Color(0xff97A7E3);
const Color splashBlueColor02 = Color(0xff92A3E2);
const Color greyColor02 = Color(0xffEEEEEE);
const Color greyColor03 = Color(0xffE0E0E0);
const Color blueGreyColor02 = Color(0xffB0BEC5);
const Color blueGreyColor05 = Color(0xff607D8B);
const Color blueColor05 = Color(0xff2196F3);
const Color redColor = Color(0xffF44336);
const Color transparentColor= Colors.transparent;

// constants variables
const String openWeatherUrl = "https://api.openweathermap.org/data/2.5/onecall";
const String apiKey = "af831683ec0fada65e12f7a95efc096a";
TextEditingController searchController;

// app screens
List<GetPage> getPages() {
  return [
    GetPage(
      name: Routes.home,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: Routes.settings,
      page: () => SettingsScreen(),
    //  bindings: SettingsController()
    )
  ];
}
