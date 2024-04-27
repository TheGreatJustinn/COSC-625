import 'package:flutter/material.dart';
import 'package:weatherplan2/utils/location_search.dart';
import 'package:weatherplan2/screens/saved_locations.dart';
import 'package:weatherplan2/utils/weather_styles.dart';

// Main screen for displaying weather information
class WeatherScreen extends StatelessWidget {
  final String currentLocation = "New York, NY";  // Mocked current location

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/WeatherPlanLogo.png', fit: BoxFit.cover, width: 200),
        backgroundColor: Color.fromARGB(255, 24, 24, 24),
      ),
      body: Column(
        children: [
          LocationSearch(),
          _buildWeatherAndForecastInfo(),
          _buildSavedLocationsSection(),
        ],
      ),
    );
  }

  // Builds the weather and forecast information section
  Widget _buildWeatherAndForecastInfo() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            WeatherInfoItem(
              location: currentLocation,
              icon: WeatherStyles.getIconForCondition('Sunny'),
              conditions: 'Sunny',
              temp: '63°F',
              backgroundColor: WeatherStyles.getBackgroundGradientForCondition('Sunny'),
            ),
            ClothingInfoItem(
              icon: WeatherStyles.getIconForCondition('Sunny'),

            )
            // Additional dynamic weather information items could be added here.
          ],
        ),
      ),
    );
  }

  // Builds the saved locations section
  Widget _buildSavedLocationsSection() {
    return Container(
      height: 150.0,
      child: SavedLocations(onSaveCurrentLocation: () {
        // Placeholder for logic to handle saving the current location
      }),
    );
  }
}

class WeatherInfoItem extends StatelessWidget {
  final String location;
  final IconData icon;
  final String conditions;
  final String temp;
  final LinearGradient backgroundColor;

  const WeatherInfoItem({
    required this.location,
    required this.icon,
    required this.conditions,
    required this.temp,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: backgroundColor),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(location, style: TextStyle(color: Colors.white, fontFamily: "juneville", fontSize: 20)),
            Icon(icon, size: 30),
            Text("$conditions, $temp", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class ClothingInfoItem extends StatelessWidget {
  final IconData icon;

  const ClothingInfoItem({
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: Icon(icon),
      ),
    );
  }
}

class ForecastInfoItem extends StatelessWidget {
  final String day;
  final String hiTemp;
  final String loTemp;
  final String conditions;
  final IconData icon;
  final LinearGradient backgroundColor;

  const ForecastInfoItem({
    required this.day,
    required this.hiTemp,
    required this.loTemp,
    required this.conditions,
    required this.icon,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListTile(
        leading: Icon(icon),
        title: Text(day),
        subtitle: Text(conditions + ". High of " + hiTemp + ", low of " + loTemp),
      ),
    );
  }
}