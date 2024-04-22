import 'package:flutter/material.dart';
import 'package:weatherplan2/utils/location_search.dart';
import 'package:weatherplan2/screens/saved_locations.dart';



class WeatherScreen extends StatelessWidget {
  final String currentLocation = "New York, NY";  // Assume this is your current location

  void saveCurrentLocation() {
    // Logic to save the location
    print("Saved location: $currentLocation");
    // Here, implement the actual saving logic, possibly involving state management or database storage
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/WeatherPlanLogo.png', width: 200),
      ),
      body: Column(
        children: [
          LocationSearch(), // Search field for location
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  WeatherInfoItem(
                    title: 'Clothing Recommendation',
                    icon: Icons.wb_sunny_outlined, // Replace with actual icon
                    value: 'Wear light clothing', // Replace with actual recommendation
                  ),
                  WeatherInfoItem(
                    title: 'Location',
                    icon: Icons.location_on,
                    value: 'New York, NY', // Replace with actual location
                  ),
                  WeatherInfoItem(
                    title: 'Weather Icon',
                    icon: Icons.wb_sunny, // Replace with actual weather icon
                    value: 'Sunny', // Replace with actual weather condition
                  ),
                  WeatherInfoItem(
                    title: 'Current Conditions',
                    icon: Icons.cloud, // Replace with actual icon
                    value: 'Cloudy', // Replace with actual condition
                  ),
                  WeatherInfoItem(
                    title: 'Current Temp',
                    icon: Icons.thermostat_outlined, // Replace with actual icon
                    value: '20°C', // Replace with actual temperature
                  ),
                  WeatherInfoItem(
                    title: 'Hi/Low Temp',
                    icon: Icons.thermostat_outlined, // Replace with actual icon
                    value: '25°C / 15°C', // Replace with actual temperatures
                  ),
                  WeatherInfoItem(
                    title: 'Wind Speed & Direction',
                    icon: Icons.air_outlined, // Replace with actual icon
                    value: '10 mph, NE', // Replace with actual wind speed and direction
                  ),
                  WeatherInfoItem(
                    title: 'Monday',
                    icon: Icons.wb_sunny_outlined, // Replace with actual weekday icon
                    value: 'hi temp - lo temp - conditions', // Replace with actual forecast
                  ),
                  WeatherInfoItem(
                    title: 'Tuesday',
                    icon: Icons.wb_sunny_outlined, // Replace with actual weekday icon
                    value: 'hi temp - lo temp - conditions', // Replace with actual forecast
                  ),
                  WeatherInfoItem(
                    title: 'Wednesday',
                    icon: Icons.wb_sunny_outlined, // Replace with actual weekday icon
                    value: 'hi temp - lo temp - conditions', // Replace with actual forecast
                  ),
                  WeatherInfoItem(
                    title: 'Thursday',
                    icon: Icons.wb_sunny_outlined, // Replace with actual weekday icon
                    value: 'hi temp - lo temp - conditions', // Replace with actual forecast
                  ),
                  WeatherInfoItem(
                    title: 'Weather Map',
                    icon: Icons.map_outlined, // Replace with actual icon
                    value: 'Actual map displayed here (ideally)', // Replace with actual action
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 150.0,
            child: SavedLocations(
              onSaveCurrentLocation: saveCurrentLocation, // Pass the save action
            ),
          ),
        ],
      ),
    );
  }
}

class WeatherInfoItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final String value;

  const WeatherInfoItem({
    required this.title,
    required this.icon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(value),
    );
  }
}
