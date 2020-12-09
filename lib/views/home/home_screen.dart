import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:weather_app/constants/app_constants.dart';
import 'package:weather_app/controllers/home_controller.dart';
import 'home_components.dart';

class HomeScreen extends StatelessWidget {
  final controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(411.42, 731.42),
      allowFontScaling: false,
    );
    return Obx(
      () {
        DateTime time = DateTime.now();
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: controller.firstTimeLoading.value
              ? splashScreen
              : ModalProgressHUD(
                  inAsyncCall: controller.isLoading.value,
                  child: GestureDetector(
                    onTap: () =>
                        FocusScope.of(context).requestFocus(FocusNode()),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            controller.backgroundPic.value,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          getFilter,
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                            ),
                            child: RefreshIndicator(
                              onRefresh: () => controller.onRefresh(),
                              child: ListView(
                                children: [
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  cityAndDatePart(
                                    cityName: controller.cityName.value,
                                    time: time,
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  getSearchField,
                                  getCurrentWeatherIcon(),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  getCurrentWeatherData(
                                    dayData: controller.dayData.value,
                                  ),
                                  getLinearChart(
                                    dayHoursForecast:
                                        controller.dayHoursForecast,
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  getDailyForecast(
                                    eightDaysForecast:
                                        controller.eightDaysForecast,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
