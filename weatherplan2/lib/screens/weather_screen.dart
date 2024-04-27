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
      backgroundColor: Color.fromARGB(255, 70, 141, 229),
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
              conditions: 'Clear',
              temp: '54°F',
              clothingAdviceTop: 'sweater',
              backgroundColor: WeatherStyles.getBackgroundGradientForCondition('Clear'),

            ),
            
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
  final String conditions;
  final String temp;
  final String clothingAdviceTop;
  final LinearGradient backgroundColor;

  const WeatherInfoItem({
    required this.location,
    required this.conditions,
    required this.temp,
    required this.clothingAdviceTop,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0), // Ensure padding matches LocationSearch
      child: Material(
        elevation: 4.0, // Adds shadow for the floating effect
        borderRadius: BorderRadius.circular(8.0), // Rounded corners
        child: Container(
          width: MediaQuery.of(context).size.width * 1,  // Set width relative to the screen size
          height: 300.0,
          decoration: BoxDecoration(
            gradient: backgroundColor, // Background gradient
            borderRadius: BorderRadius.circular(8.0), // Rounded corners
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Padding inside the container
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(location, style: TextStyle(color: Colors.white, fontFamily: "juneville", fontSize: 20)),
                Container(
                  width: 100.0,  // Width for the Lottie animation
                  height: 100.0,  // Height for the Lottie animation
                  child: WeatherStyles.getAnimationForCondition(conditions),  // Get Lottie animation for the condition
                ),
                Text("$conditions, $temp", style: TextStyle(color: Colors.white, fontSize: 16)),
                Text("You need to wear a $clothingAdviceTop, dawg.")
              ],
            ),
          ),
        ),
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