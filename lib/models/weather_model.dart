
class Weather {
  final String cityName;
  final double temperature;
  final double tempMin;
  final double tempMax;
  final String mainCondition;
  final double windSpeed;
  final String icon;
  final double latitude;
  final double longitude;
  final int sunrise;
  final int sunset;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.tempMin,
    required this.tempMax,
    required this.mainCondition,
    required this.windSpeed,
    required this.icon,
    required this.latitude,
    required this.longitude,
    required this.sunrise,
    required this.sunset,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      tempMin: json['main']['temp_min'].toDouble(),
      tempMax: json['main']['temp_max'].toDouble(),
      mainCondition: json['weather'][0]['main'],
      windSpeed: json['wind']['speed'].toDouble(),
      icon: json['weather'][0]['icon'],
      latitude: json['coord']['lat'].toDouble(),
      longitude: json['coord']['lon'].toDouble(),
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
    );
  }
}
