class DayForecast {
  final num temp;
  final int sunrise;
  final int sunset;
  final String description;
  final num wind;
  final int humidity;
  final int pressure;
  final String iconCode;

  DayForecast({
    this.temp,
    this.sunrise,
    this.sunset,
    this.description,
    this.wind,
    this.humidity,
    this.pressure,
    this.iconCode
  });

  factory DayForecast.fromJson(Map<String, dynamic> data) {
    return DayForecast(
      temp: data['current']['temp'],
      sunrise: data['current']['sunrise'],
      sunset: data['current']['sunset'],
      description: data['current']['weather'][0]['description'],
      wind: data['current']['wind_speed'],
      humidity: data['current']['humidity'],
      pressure: data['current']['pressure'],
      iconCode: data['current']['weather'][0]['icon']
    );
  }
}
