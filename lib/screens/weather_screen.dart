import 'package:flutter/material.dart';
import 'package:weatherplan2/screens/settings.dart';
import 'package:weatherplan2/utils/location_search.dart';
import 'package:weatherplan2/screens/saved_locations.dart';
import 'package:weatherplan2/utils/api.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key, required this.isDarkMode, required this.isCelsius, required this.updateSettings}) : super(key: key);
  final bool isDarkMode;
  final bool isCelsius;
  final Function(bool, bool) updateSettings;

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  List<MyWeatherData> weatherDataList = [];
  List<List<String>> savedLocations = [];
  bool _isCelsius = false;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _isCelsius = widget.isCelsius;
  }

  @override
  void didUpdateWidget(WeatherScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isCelsius != widget.isCelsius) {
      setState(() {
        _isCelsius = widget.isCelsius;
      });
      fetchWeatherData(_controller.text);
    }
  }

  void fetchWeatherData(String zipCode) async {
    List<MyWeatherData> data = await WeatherApi.getWeatherData(zipCode, _isCelsius);
    setState(() {
      weatherDataList = data;
    });
  }

  void saveCurrentLocation() {
    if (weatherDataList.isNotEmpty) {
      var cityName = weatherDataList[0].cityName;
      var temperature = '${weatherDataList[0].temperature}';
      var shortForecast = weatherDataList[0].shortForecast;

      if (cityName != null && temperature.isNotEmpty && shortForecast != null) {
        var currentLocation = [
          cityName,
          temperature,
          shortForecast,
        ];
        setState(() {
          if (savedLocations.length >= 5) {
            savedLocations.removeAt(0);
          }
          savedLocations.add(currentLocation);
        });
      } else {
        print("Invalid weather data. Cannot save location.");
      }
    } else {
      print("No weather data available to save location.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/WeatherPlanLogo.png', width: 200),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(
                    isDarkMode: widget.isDarkMode,
                    isCelsius: widget.isCelsius,
                    updateSettings: widget.updateSettings,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          LocationSearch(
            onSearch: fetchWeatherData,
            isCelsius: _isCelsius,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: _buildWeatherInfoItems(),
              ),
            ),
          ),
          Container(
            height: 150.0,
            child: SavedLocations(
              onSaveCurrentLocation: saveCurrentLocation,
              locationsData: savedLocations,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildWeatherInfoItems() {
    Map<String, List<MyWeatherData>> groupedData = {};

    for (var weatherData in weatherDataList) {
      String day = weatherData.name.split(' ')[0];
      groupedData.putIfAbsent(day, () => []).add(weatherData);
    }

    List<Widget> widgets = [];

    groupedData.forEach((day, dataList) {
      widgets.add(
        Column(
          children: [
            Text(day, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            for (var weatherData in dataList)
              WeatherInfoItem(
                location: '${weatherData.cityName}, ${weatherData.stateName}',
                icon: Icons.wb_sunny_outlined,
                conditions: weatherData.shortForecast,
                temp: '${weatherData.temperature}',
                isCelsius: _isCelsius,
                backgroundColor: Colors.grey.shade300,
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
  final bool isCelsius;
  final Color backgroundColor;

  const WeatherInfoItem({
    required this.location,
    required this.icon,
    required this.conditions,
    required this.temp,
    required this.isCelsius,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      color: backgroundColor,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
              "$conditions, $temp${isCelsius ? '°C' : '°F'}",
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