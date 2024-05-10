import 'package:flutter/material.dart';
import 'package:weatherplan2/utils/location_search.dart';
import 'package:weatherplan2/screens/saved_locations.dart';
import 'package:weatherplan2/utils/api.dart'; // Import the WeatherApi class

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  List<MyWeatherData> weatherDataList = [];

  void initState() {
    super.initState();
  }

  void fetchWeatherData(String zipCode) async {
    List<MyWeatherData> data = await WeatherApi.getWeatherData(zipCode);
    setState(() {
      weatherDataList = data;
    });
  }

  void saveCurrentLocation() {
    // Logic to save the location
    var currentLocation;
    print("Saved location: $currentLocation");
    // Here, implement the actual saving logic, possibly involving state management or database storage
    // Don't forget to check if location already exists in saved locations
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/WeatherPlanLogo.png', width: 200),
      ),
      body: Column(
        children: [
          LocationSearch(
            onSearch: fetchWeatherData, // Passes the fetchWeatherData method to LocationSearch
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: _buildWeatherInfoItems(), // Use a function to build WeatherInfoItems
              ),
            ),
          ),
          Container(
            height: 150.0,
            child: SavedLocations(
              onSaveCurrentLocation: saveCurrentLocation,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildWeatherInfoItems() {
    // Group weather data by day
    Map<String, List<MyWeatherData>> groupedData = {};

    for (var weatherData in weatherDataList) {
      String day = weatherData.name.split(' ')[0]; // Extract day from the name
      groupedData.putIfAbsent(day, () => []).add(weatherData);
    }

    // Create WeatherInfoItem for each day
    List<Widget> widgets = [];

    groupedData.forEach((day, dataList) {
      widgets.add(
        Column(
          children: [
            Text(day, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            for (var weatherData in dataList)
              WeatherInfoItem(
                location: '${weatherData.cityName}, ${weatherData.stateName}',
                icon: Icons.wb_sunny_outlined, // Replace with ACTUAL weather icon
                conditions: weatherData.shortForecast,
                temp: '${weatherData.temperature}',
                backgroundColor: Colors.grey.shade300, // Use a default color for now
              ),
            const SizedBox(height: 10),
          ],
        ),
      );
    });

    return widgets;
  }
}

class WeatherInfoItem extends StatelessWidget {
  final String location;
  final IconData icon;
  final String conditions;
  final String temp;
  final Color backgroundColor;

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
      height: 300.0,
      color: backgroundColor, // Use the background color
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Use the minimal space needed by the child
          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
          crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
          children: [
            Text(
              location,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(
              icon,
              size: 30,
            ),
            Text(
              "$conditions, $temp",
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
