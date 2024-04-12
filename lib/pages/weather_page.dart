
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:new_weather/models/settings_model.dart';
import 'package:new_weather/models/weather_model.dart';
import 'package:new_weather/service/weather_service.dart';


class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key, required this.isDarkMode, required this.isCelsius, required this.updateSettings});
final bool isDarkMode;
  final bool isCelsius;
  final Function(bool, bool) updateSettings;
  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {




  // api key
  final _weatherService = WeatherService('ee61e1aa9d37b109de56b9a72cb504dc');
  Weather? _weather;

  // fetch weather
_fetchWeather() async {
  // get the current city
  String cityName = await _weatherService.getCurrentCity();

  // get weather for city
  try {
    final weather = await _weatherService.getWeather(cityName);
    setState(() {
      _weather = weather;
    });
  }
  // any errors
  catch (e) {
    print(e);
  }
}

  // weather animations
  String getWeatherAnimation(String? mainCondition) {
  if (mainCondition == null) return 'assets/sunny.json'; //default to sunny


  switch (mainCondition.toLowerCase()) {
    case 'clouds':
    return 'assets/partlycloudyday.json';
    case 'mist':
    return 'assets/mist.json';
    case 'smoke':
    return 'assets/mist.json';
    case 'haze':
    return 'assets/mist.json';
    case 'dust':
    return 'assets/mist.json';
    case 'fog':
    return 'assets/mist.json';
    case 'rain':
    return 'assets/rainyday.json';
    case 'drizzle':
    return 'assets/rainyday.json';
    case 'shower rain':
    return 'assets/mist.json';
    case 'thunderstorm':
    return 'assets/storm.json';
    case 'clear':
    return 'assets/sunny.json';
    default:
    return 'assets/sunny.json';
  }

}


  // init state
  @override
  void initState() {
    super.initState();
     // fetch weather on startup
  _fetchWeather();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WeatherPlan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage(
                   isDarkMode: widget.isDarkMode,
                    isCelsius: widget.isCelsius,
                    updateSettings: widget.updateSettings,)),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
          children: [
                     // city name
            Text(_weather?.cityName ?? "loading city.."),

            //animation
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

            // temperature
            Text('${_weather?.temperature.round()}˚F'),
            const Text('Low-High'),


            Text('${_weather?.tempMin.round()}-${_weather?.tempMax.round()}°F'),

             // weather condition
            Text(_weather?.mainCondition ?? ""),


            // Additional widget underneath the weather content
          Container(
              // ...
            ),
          ],
        ),
      ),
    );
  }
}
   
  



