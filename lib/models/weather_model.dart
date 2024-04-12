import 'dart:core';


class Weather {
  final String cityName;
  final double temperature;
  final double tempMin;
  final double tempMax;
  final String mainCondition;

  Weather({required this.cityName, 
  required this.temperature, 
  required this.mainCondition,
  required this.tempMin,
  required this.tempMax,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      mainCondition: json['weather'][0]['main'], 
      tempMin: json['main']['temp_min'].toDouble(),
      tempMax: json['main']['temp_max'].toDouble(),
      );
  }
} 