import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'config/routes.dart';
import 'constants/app_constants.dart';

void main() async {
  GetStorage.init();
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(
      [SystemUiOverlay.bottom],
    );
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Weather App",
      defaultTransition: Transition.cupertino,
      getPages: getPages(),
      initialRoute: Routes.home,
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: whiteColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}
