import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:new_weather/models/weather_model.dart';
import 'package:http/http.dart' as http;



class WeatherService {

  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  static const WEATHER_GOV_BASE_URL = 'https://api.weather.gov';

  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async {
    final response = await http.get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=imperial'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<String> getCurrentCity() async {

    //get permission for location

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    //fetch current location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high );

    // convert the location into a list of placemark objects
    List<Placemark> placemarks = 
    await placemarkFromCoordinates(position.latitude, position.longitude);

    // extract the city name from the first placemark
    String? city = placemarks[0].locality;
    return city ?? "";
  }
  Future<List<String>> getDailyForecast() async {
    // Get the current position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Make the API request to weather.gov using the latitude and longitude
    final response = await http.get(Uri.parse(
      '$WEATHER_GOV_BASE_URL/points/${position.latitude},${position.longitude}',
    ));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final forecastUrl = jsonData['properties']['forecast'];

      // Make the API request to the forecast URL
      final forecastResponse = await http.get(Uri.parse(forecastUrl));

      if (forecastResponse.statusCode == 200) {
        final forecastData = jsonDecode(forecastResponse.body);
        final periods = forecastData['properties']['periods'];

        // Extract the forecast for each period
        List<String> dailyForecast = periods.map<String>((period) {
          final name = period['name'];
          final temperature = period['temperature'];
          final windSpeed = period['windSpeed'];
          final shortForecast = period['shortForecast'];

          return '$name: $temperature°F, $windSpeed, $shortForecast';
        }).toList();

        return dailyForecast;
      } else {
        throw Exception('Failed to load forecast data');
      }
    } else {
      throw Exception('Failed to load location data');
    }
  }


   Future<Weather> getSearch(String city) async {
    final queryParameters = {
      'q': city,
      'appid': 'ee61e1aa9d37b109de56b9a72cb504dc',
      'units': 'imperial',
    };

    final uri = Uri.https(
      'api.openweathermap.org',
      '/data/2.5/weather',
      queryParameters,
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}