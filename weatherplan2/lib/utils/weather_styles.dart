import 'package:flutter/material.dart';

// Central class for defining weather-related styles
class WeatherStyles {
  static final Map<String, LinearGradient> weatherGradients = {
    "Sunny": LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFF64A2F0), Color(0xFFB5D2FC)],
    ),
    "Cloudy": LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.grey.shade300, Colors.grey.shade500],
    ),
    "Rainy": LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.blueGrey, Colors.blue.shade900],
    ),
    "Snowy": LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.grey, Colors.white],
    ),
  };

  static final Map<String, IconData> weatherIcons = {
    "Sunny": Icons.wb_sunny_outlined,
    "Cloudy": Icons.wb_cloudy_outlined,
    "Rainy": Icons.water_drop_outlined,
    "Snowy": Icons.ac_unit,
  };

  static final Map<String, IconData> clothingIcons = {
    "Sunny": Icons.woman,
    "Cloudy": Icons.woman,
    "Rainy": Icons.woman,
    "Snowy": Icons.woman,
  };

  // Retrieves the background gradient for a given weather condition
  static LinearGradient getBackgroundGradientForCondition(String condition) {
    return weatherGradients[condition] ?? LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [const Color.fromARGB(255, 255, 255, 255), const Color.fromARGB(255, 255, 255, 255)], // Default gradient
    );
  }

  // Retrieves the icon for a given weather condition
  static IconData getIconForCondition(String condition) {
    return weatherIcons[condition] ?? Icons.error_outline;  // Default icon if condition not found
  }

  static IconData getClothingIconForCondition(String condition) {
    return weatherIcons[condition] ?? Icons.error_outline;  // Default icon if condition not found
  }
}
