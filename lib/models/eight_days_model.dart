class EightDayForecast {
  final int dt;
  final num maxTemp;
  final num minTemp;
  final String description;
  final iconCode;

  EightDayForecast({
    this.dt,
    this.maxTemp,
    this.minTemp,
    this.description,
    this.iconCode
  });

  factory EightDayForecast.fromJson(Map<String, dynamic> data, int index) {
    return EightDayForecast(
      dt: data['daily'][index]['dt'],
      maxTemp: data['daily'][index]['temp']['max'],
      minTemp: data['daily'][index]['temp']['min'],
      description: data['daily'][index]['weather'][0]['description'],
      iconCode: data['daily'][index]['weather'][0]['icon'],
    );
  }
}
