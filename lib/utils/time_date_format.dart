import 'package:intl/intl.dart';

int hour = 0;
String minute = "";
String format = "";
String dayName = "";

void getHour({int hor}) {
  if (hor > 12) {
    hour = hor - 12;
    format = "PM";
  } else if (hor == 0) {
    hour = 12;
    format = "AM";
  } else if (hor == 12) {
    hour = hor;
    format = "PM";
  } else {
    hour = hor;
    format = "AM";
  }
}

void getMinute({int min}) {
  if (min < 10)
    minute = '0' + min.toString();
  else
    minute = min.toString();
}

void getDayName({DateTime time}) {
  dayName = DateFormat('EEEE').format(time);
}

String getTimeDateFormat({DateTime time}) {
  // check hours
  getHour(hor: time.hour);

  // check minutes
  getMinute(min: time.minute);

  // get today name
  getDayName(time: time);

  return dayName +
      ' ' +
      time.day.toString() +
      '-' +
      time.month.toString() +
      '-' +
      time.year.toString() +
      ', ' +
      hour.toString() +
      ':' +
      minute +
      ' ' +
      format;
}

String getTimeFormat({DateTime time, bool takeMin}) {
  if (takeMin) {
    getHour(hor: time.hour);
    getMinute(min: time.minute);
    return hour.toString() + ':' + minute + ' ' + format;
  } else {
    getHour(hor: time.hour);
    return hour.toString() + format;
  }
}

DateTime timestampToDateTime(timestamp) {
  return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
}
