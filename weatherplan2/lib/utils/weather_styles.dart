import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// Central class for defining weather-related styles
class WeatherStyles {
  static final Map<String, LinearGradient> weatherGradients = {
    "Clear": LinearGradient(
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

  static final Map<String, Widget> weatherAnimations = {
    "Clear": Lottie.asset('assets/animation_clear.json'),
    "Cloudy": Lottie.asset('assets/animation_cloudy.json'),
    "Rainy": Lottie.asset('assets/animation_rainy.json'),
    "Snowy": Lottie.asset('assets/animation_snowy.json'),
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
  static Widget getAnimationForCondition(String condition) {
    return weatherAnimations[condition] ?? Lottie.asset('assets/animation_clear.json');  // Default icon if condition not found
  }
}
