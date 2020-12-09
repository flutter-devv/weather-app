import 'package:get/get.dart';
import 'package:weather_app/constants/app_assets.dart';
import 'package:weather_app/controllers/home_controller.dart';

String currentIcon = "";
String backgroundPic = "";
final controller = Get.find<HomeController>();
String checkWeatherIcon({String iconCode, bool isBackgroundPic = false}) {
  switch (iconCode) {
    case '01d':
      currentIcon = sunnyIcon;
      backgroundPic = clearPic;
      break;
    case '02d':
      currentIcon = dayFewCloudsIcon;
      backgroundPic = lightCloudsPic;
      break;
    case '04d':
    case '04n':
      currentIcon = brokenCloudsIcon;
      backgroundPic = brokenCloudsPic;
      break;
    case '50d':
    case '50n':
      currentIcon = mistIcon;
      backgroundPic = mistPic;
      break;
    case '13d':
    case '13n':
      currentIcon = snowIcon;
      backgroundPic = snowPic;
      break;
    case '11d':
    case '11n':
      currentIcon = thunderstormIcon;
      backgroundPic = thunderstormPic;
      break;
    case '09d':
    case '09n':
      currentIcon = showerRainIcon;
      backgroundPic = showerRainPic;
      break;
    case '10d':
      currentIcon = rainIcon;
      backgroundPic = dayRainPic;
      break;
    case '10n':
      currentIcon = rainIcon;
      backgroundPic = nightRainPic;
      break;
    case '01n':
      currentIcon = moonIcon;
      backgroundPic = nightClearPic;
      break;
    case '02n':
      currentIcon = nightFewCloudsIcon;
      backgroundPic = nightFewCloudsPic;
      break;
    case '03d':
      currentIcon = dayScatteredCloudsIcon;
      backgroundPic = dayScatteredCloudsPic;
      break;
    case '03n':
      currentIcon = nightScatteredCloudsIcon;
      backgroundPic = nightScatteredCloudsPic;
      break;
  }
  return isBackgroundPic ? backgroundPic : currentIcon;
}
