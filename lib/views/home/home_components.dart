import 'dart:ui';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/config/routes.dart';
import 'package:weather_app/constants/app_assets.dart';
import 'package:weather_app/constants/app_constants.dart';
import 'package:weather_app/controllers/home_controller.dart';
import 'package:weather_app/controllers/settings_controller.dart';
import 'package:weather_app/models/current_day_model.dart';
import 'package:weather_app/models/eight_days_model.dart';
import 'package:weather_app/utils/linear_chart.dart';
import 'package:weather_app/utils/time_date_format.dart';
import 'package:weather_app/widgets/custom_text.dart';

final controller = Get.find<HomeController>();
final settingsController = Get.put(SettingsController());

// city name, date and time
Widget cityAndDatePart({
  String cityName,
  DateTime time,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          Icon(
            Icons.location_on,
            color: whiteColor,
            size: 23.w,
          ),
          SizedBox(
            width: 15.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customBoldText(
                text: cityName,
                color: whiteColor,
              ),
              customThinText(
                text: getTimeDateFormat(
                  time: time,
                ),
                color: whiteColor,
              ),
            ],
          ),
        ],
      ),
      getSettingsIcon(
        () => Get.toNamed(Routes.settings),
      )
    ],
  );
}

Widget getSettingsIcon(GestureTapCallback onPressed) {
  return Material(
    color: Colors.transparent,
    child: IconButton(
      icon: Icon(
        Icons.settings,
        color: whiteColor,
        size: 23.w,
      ),
      alignment: Alignment.centerRight,
      padding: EdgeInsets.all(0.0),
      splashRadius: 30.w,
      onPressed: onPressed,
    ),
  );
}

// splash screen
Widget splashScreen = Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [
        splashBlueColor01,
        splashBlueColor02,
      ],
    ),
  ),
  width: Get.width,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image(
        image: AssetImage(appIcon),
        height: 95.h,
        width: 95.w,
      ),
      SizedBox(height: 5.h),
      customBoldText(
        text: "Weatherman",
        color: whiteColor,
        letterSpacing: 0.5,
      ),
    ],
  ),
);

// search text field
Widget getSearchField = Align(
  alignment: Alignment.centerRight,
  child: TextFormField(
    controller: searchController,
    style: TextStyle(
      color: whiteColor,
    ),
    decoration: InputDecoration(
      contentPadding: EdgeInsets.only(
        left: 10.w,
      ),
      isDense: true,
      suffixIconConstraints: BoxConstraints(
        minWidth: 10.w,
        minHeight: 45.h,
      ),
      suffixIcon: Icon(
        Icons.search,
        color: whiteColor,
        size: 23.w,
      ),
    ),
    onFieldSubmitted: (val) => controller.getDayData(cityName: val).then(
          (value) => searchController.clear(),
        ),
  ),
);

// current weather icon
Widget getCurrentWeatherIcon() {
  return Padding(
    padding: EdgeInsets.only(
      top: 30.h,
      left: 20.w,
    ),
    child: Image(
      image: AssetImage(
        controller.currentWeatherIcon.value,
      ),
      height: 90.h,
      width: 90.w,
      alignment: Alignment.centerLeft,
    ),
  );
}

// current weather data
Widget getCurrentWeatherData({DayForecast dayData}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          weatherTemp(
            temp: dayData.temp,
          ),
          customNormalText(
            text: controller.dayData.value.description,
            fontSize: 25.w,
          ),
          SizedBox(height: 20.h),
          SizedBox(
            height: 40.h,
            child: Row(
              children: [
                sunriseAndSunsetItem(
                  label: "sunrise",
                  value: dayData.sunrise,
                ),
                VerticalDivider(
                  color: greyColor03,
                ),
                sunriseAndSunsetItem(
                  label: "sunset",
                  value: dayData.sunset,
                ),
              ],
            ),
          ),
        ],
      ),
      Spacer(),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          weatherInfo(
            title: "Wind",
            image: windLogo,
            value: dayData.wind,
          ),
          weatherInfo(
            title: "humidity",
            image: humidityLogo,
            value: dayData.humidity,
          ),
          weatherInfo(
            title: "pressure",
            image: pressureLogo,
            value: dayData.pressure,
          ),
        ],
      ),
    ],
  );
}

Widget weatherTemp({num temp}) {
  String unit;
  if (settingsController.groupValue.value == 1) {
    temp = (temp * 9 / 5) + 32;
    unit = "F";
  } else if (settingsController.groupValue.value == 2) {
    temp = temp + 273.15;
    unit = "K";
  } else {
    unit = "C";
  }

  return Text(
    "${temp.toStringAsFixed(1)} °$unit",
    style: TextStyle(
      color: whiteColor,
      fontWeight: FontWeight.bold,
      fontSize: 58.w,
    ),
  );
}

Widget sunriseAndSunsetItem({String label, int value}) {
  return Column(
    children: [
      Text(
        label,
        style: TextStyle(
          color: greyColor02,
          fontSize: 15.w,
        ),
      ),
      Text(
        getTimeFormat(
          time: DateTime.fromMillisecondsSinceEpoch(
            value * 1000,
          ),
          takeMin: true,
        ),
        style: TextStyle(
          color: whiteColor,
          fontSize: 15.w,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}

Widget weatherInfo({
  String title,
  String image,
  num value,
}) {
  String unitMeasuring = "";
  if (title == "Wind")
    unitMeasuring = "m/s";
  else if (title == "humidity")
    unitMeasuring = "%";
  else
    unitMeasuring = "pa";
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
          color: Colors.grey[200],
          fontSize: 15.w,
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image(
            image: AssetImage(image),
            height: 40.h,
            width: 40.w,
          ),
          Text(
            value.toString() + unitMeasuring,
            style: TextStyle(
              color: whiteColor,
              fontSize: 15.w,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ],
  );
}

// linear chart for hourly forecast
Widget getLinearChart({
  List<Map<String, dynamic>> dayHoursForecast,
}) {
  return Container(
    margin: EdgeInsets.only(
      top: 80.h,
    ),
    height: 100.h,
    width: Get.width,
    padding: EdgeInsets.symmetric(
      horizontal: 20.w,
    ),
    child: LineChart(
      dayForecastChart(temps: [
        dayHoursForecast[0]['temp'].toStringAsFixed(1),
        dayHoursForecast[1]['temp'].toStringAsFixed(1),
        dayHoursForecast[2]['temp'].toStringAsFixed(1),
        dayHoursForecast[3]['temp'].toStringAsFixed(1),
        dayHoursForecast[4]['temp'].toStringAsFixed(1),
        dayHoursForecast[5]['temp'].toStringAsFixed(1),
        dayHoursForecast[6]['temp'].toStringAsFixed(1),
        dayHoursForecast[7]['temp'].toStringAsFixed(1),
      ], times: [
        getTimeFormat(
          time: timestampToDateTime(dayHoursForecast[0]['time']),
          takeMin: false,
        ),
        getTimeFormat(
          time: timestampToDateTime(dayHoursForecast[1]['time']),
          takeMin: false,
        ),
        getTimeFormat(
          time: timestampToDateTime(dayHoursForecast[2]['time']),
          takeMin: false,
        ),
        getTimeFormat(
          time: timestampToDateTime(dayHoursForecast[3]['time']),
          takeMin: false,
        ),
        getTimeFormat(
          time: timestampToDateTime(dayHoursForecast[4]['time']),
          takeMin: false,
        ),
        getTimeFormat(
          time: timestampToDateTime(dayHoursForecast[5]['time']),
          takeMin: false,
        ),
        getTimeFormat(
          time: timestampToDateTime(dayHoursForecast[6]['time']),
          takeMin: false,
        ),
        getTimeFormat(
          time: timestampToDateTime(dayHoursForecast[7]['time']),
          takeMin: false,
        ),
      ]),
    ),
  );
}

// list view for daily forecast
Widget getDailyForecast({
  List<EightDayForecast> eightDaysForecast,
}) {
  return Container(
    height: 90.h,
    child: ListView.separated(
      itemCount: 8,
      itemBuilder: (context, index) {
        var date = DateTime.fromMillisecondsSinceEpoch(
          controller.eightDaysForecast[index].dt * 1000,
        );
        String dayName = DateFormat('EEEE').format(date).substring(0, 3);
        return Column(
          children: [
            customNormalText(
              text: dayName,
              fontSize: 15.w,
            ),
            SizedBox(height: 5.h),
            Image(
              image: AssetImage(
                controller.dailyWeatherIcons[index],
              ),
              height: 30.h,
              width: 30.w,
            ),
            SizedBox(height: 10.h),
            SizedBox(
              height: 20.h,
              child: Row(
                children: [
                  customNormalText(
                    text: controller.eightDaysForecast[index].maxTemp
                            .toStringAsFixed(0) +
                        '°',
                    fontSize: 15.w,
                  ),
                  VerticalDivider(
                    color: greyColor03,
                  ),
                  customNormalText(
                    text: controller.eightDaysForecast[index].maxTemp
                            .toStringAsFixed(0) +
                        '°',
                    fontSize: 15.w,
                  ),
                ],
              ),
            )
          ],
        );
      },
      separatorBuilder: (context, index) => VerticalDivider(
        color: greyColor03,
      ),
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
    ),
  );
}

// background image filter
Widget getFilter = BackdropFilter(
  filter: ImageFilter.blur(
    sigmaX: 5.0,
    sigmaY: 5.0,
  ),
  child: Container(
    color: Colors.black.withOpacity(0.1),
  ),
);
