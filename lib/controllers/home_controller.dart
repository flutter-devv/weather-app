import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_app/constants/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/current_day_model.dart';
import 'package:weather_app/models/eight_days_model.dart';
import 'package:weather_app/utils/check_weather_icon.dart';
import 'package:weather_app/widgets/default_dialog.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool firstTimeLoading = true.obs;
  double latitude = 0.0, longitude = 0.0;
  RxString cityName = "Gaza".obs;
  Rx<DayForecast> dayData = DayForecast().obs;
  RxList<EightDayForecast> eightDaysForecast = List<EightDayForecast>(8).obs;
  RxList<Map<String, dynamic>> dayHoursForecast =
      List<Map<String, dynamic>>.generate(8, (index) => {}).obs;
  RxString currentWeatherIcon = "".obs;
  RxList<String> dailyWeatherIcons = List<String>(8).obs;
  RxString backgroundPic = "".obs;

  Future<void> getDayData({
    String cityName,
    bool isRefresh = false,
  }) async {
    isLoading.value = isRefresh ? false : true;
    try {
      if (cityName != null) {
        List<Location> location = await locationFromAddress(cityName);
        latitude = location[0].latitude;
        longitude = location[0].longitude;
        this.cityName.value = cityName;
      } else {
        final Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        latitude = position.latitude;
        longitude = position.longitude;
      }
      var url =
          '$openWeatherUrl?lat=$latitude&lon=$longitude&units=metric&appid=$apiKey';
      var response = await http.get(url);
      var result = json.decode(response.body);
      // day weather data
      dayData.value = DayForecast.fromJson(result);
      // current weather icon
      currentWeatherIcon.value = checkWeatherIcon(
        iconCode: dayData.value.iconCode,
      );
      backgroundPic.value = checkWeatherIcon(
          iconCode: dayData.value.iconCode, isBackgroundPic: true);
      // week days data
      for (int i = 0; i <= 7; ++i) {
        eightDaysForecast[i] = EightDayForecast.fromJson(result, i);
        dailyWeatherIcons[i] = checkWeatherIcon(
          iconCode: eightDaysForecast[i].iconCode,
        );
      }
      // day hours data
      for (int i = 0; i <= 7; ++i) {
        dayHoursForecast[i]['temp'] = result['hourly'][i]['temp'];
        dayHoursForecast[i]['time'] = result['hourly'][i]['dt'];
      }
      isLoading.value = false;
      firstTimeLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      // no internet connection
      if (e.toString().contains("no internet"))
        customDialog(
          content: "Please check your internet!",
          confirmText: "try again",
          onPressed: () {
            Get.close(1);
            getDayData();
          },
        );
      // no address found
      else
        customDialog(
          content: "No address found!",
          confirmText: "ok",
          onPressed: () => Get.close(1),
        );
    }
  }

  onRefresh() async {
    await getDayData(isRefresh: true);
  }

  @override
  void onInit() {
    getDayData();
    searchController = TextEditingController();
    super.onInit();
  }
}
