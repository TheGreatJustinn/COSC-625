
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:new_weather/models/settings_model.dart';
import 'package:new_weather/models/weather_model.dart';
import 'package:new_weather/service/weather_service.dart';
import 'package:new_weather/utils/weather_utils.dart';


class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key, required this.isDarkMode, required this.isCelsius, required this.updateSettings});
final bool isDarkMode;
  final bool isCelsius;
  final Function(bool, bool) updateSettings;
  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

bool _isSearching = false;
  final _searchController = TextEditingController();
  List<String>? _dailyForecast;


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
_fetchDailyForecast() async {
    try {
      final forecast = await _weatherService.getDailyForecast();
      setState(() {
        _dailyForecast = forecast;
      });
    } catch (e) {
      print(e);
    }
  }
  _fetchWeatherForCity(String city) async {
    try {
      final weather = await _weatherService.getSearch(city);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  bool isNighttime(int sunrise, int sunset) {
  final currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  return currentTime < sunrise || currentTime > sunset;
}

String getClothingSuggestion(double temperature, String mainCondition, double windSpeed,) {
  if (temperature <= 32) {
    if (mainCondition == 'Snow') {
      if (windSpeed >= 20) {
        return 'It\'s freezing, snowy, and windy. Wear a warm, windproof coat, thick gloves, a hat, a scarf, and insulated snow boots.';
      } else {
        return 'It\'s freezing and snowy. Wear a warm coat, gloves, a hat, and snow boots.';
      }
    } else {
      if (windSpeed >= 20) {
        return 'It\'s extremely cold and windy. Wear a heavy, windproof coat, gloves, a hat, a scarf, and warm, insulated boots.';
      } else {
        return 'It\'s extremely cold. Wear a heavy coat, gloves, a hat, and warm boots.';
      }
    }
  } else if (temperature <= 50) {
    if (mainCondition == 'Rain') {
      if (windSpeed >= 15) {
        return 'It\'s chilly, rainy, and windy. Wear a waterproof, windproof jacket, waterproof boots, and carry an umbrella.';
      } else {
        return 'It\'s chilly and rainy. Wear a raincoat, waterproof boots, and carry an umbrella.';
      }
    } else {
      if (windSpeed >= 15) {
        return 'It\'s chilly and windy. Wear a warm, windproof jacket or coat, and consider layering with a sweater and a scarf.';
      } else {
        return 'It\'s chilly. Wear a jacket or a coat, and consider layering with a sweater.';
      }
    }
  } else if (temperature <= 68) {
    if (mainCondition == 'Clear') {
      if (windSpeed >= 10) {
        return 'It\'s mild, sunny, and breezy. Wear a light jacket or a long-sleeved shirt, comfortable pants, and closed-toe shoes.';
      } else {
        return 'It\'s mild and sunny. Wear a light jacket or a long-sleeved shirt, and comfortable shoes.';
      }
    } else {
      if (windSpeed >= 10) {
        return 'It\'s mild and breezy. Wear a light jacket or a sweater, comfortable pants or jeans, and closed-toe shoes.';
      } else {
        return 'It\'s mild. Wear a light jacket or a sweater, and comfortable pants or jeans.';
      }
    }
  } else if (temperature <= 85) {
    if (mainCondition == 'Clear') {
      if (windSpeed >= 10) {
        return 'It\'s warm, sunny, and breezy. Wear lightweight, breathable clothes like shorts, a t-shirt, and sandals. Consider a light jacket or a thin, long-sleeved shirt for sun protection.';
      } else {
        return 'It\'s warm and sunny. Wear lightweight, breathable clothes like shorts, a t-shirt, and sandals. Don\'t forget sunglasses and sunscreen!';
      }
    } else {
      if (windSpeed >= 10) {
        return 'It\'s warm and breezy. Wear lightweight, breathable clothes like a short-sleeved shirt, shorts or a skirt, and comfortable shoes. Consider a light jacket or a thin, long-sleeved shirt.';
      } else {
        return 'It\'s warm. Wear lightweight, breathable clothes like a short-sleeved shirt and shorts or a skirt.';
      }
    }
  } else {
    if (mainCondition == 'Clear') {
      if (windSpeed >= 10) {
        return 'It\'s hot, sunny, and breezy. Wear lightweight, loose-fitting clothes like a tank top, shorts, and sandals. Consider a wide-brimmed hat and sunglasses for sun protection.';
      } else {
        return 'It\'s hot and sunny. Wear lightweight, loose-fitting clothes like a tank top, shorts, and sandals. Stay hydrated and seek shade when possible.';
      }
    } else {
      if (windSpeed >= 10) {
        return 'It\'s hot and breezy. Wear lightweight, breathable clothes like a t-shirt, shorts, and sandals. Consider a hat or a light, long-sleeved shirt for sun protection.';
      } else {
        return 'It\'s hot. Wear lightweight, breathable clothes like a t-shirt, shorts, and sandals. Consider a hat for sun protection.';
      }
    }
  }
}

String getDefaultClothingSuggestion(double temperature, String mainCondition, double windSpeed) {
  if (temperature <= 32) {
    if (windSpeed >= 20) {
      return 'It\'s extremely cold and windy. Wear warm layers, a heavy, windproof coat, gloves, a hat, and a scarf.';
    } else {
      return 'It\'s extremely cold. Wear warm layers, a heavy coat, gloves, and a hat.';
    }
  } else if (temperature <= 50) {
    if (windSpeed >= 15) {
      return 'It\'s chilly and windy. Wear a warm, windproof jacket or coat, and consider layering with a sweater and a scarf.';
    } else {
      return 'It\'s chilly. Wear a jacket or a coat, and consider layering with a sweater.';
    }
  } else if (temperature <= 68) {
    if (windSpeed >= 10) {
      return 'It\'s mild and breezy. Wear a light jacket or a sweater, comfortable pants or jeans, and closed-toe shoes.';
    } else {
      return 'It\'s mild. Wear a light jacket or a sweater, and comfortable pants or jeans.';
    }
  } else if (temperature <= 85) {
    if (windSpeed >= 10) {
      return 'It\'s warm and breezy. Wear lightweight, breathable clothes like a short-sleeved shirt, shorts or a skirt, and comfortable shoes. Consider a light jacket or a thin, long-sleeved shirt.';
    } else {
      return 'It\'s warm. Wear lightweight, breathable clothes like a short-sleeved shirt and shorts or a skirt.';
    }
  } else {
    if (windSpeed >= 10) {
      return 'It\'s hot and breezy. Wear lightweight, breathable clothes like a t-shirt, shorts, and sandals. Consider a hat or a light, long-sleeved shirt for sun protection.';
    } else {
      return 'It\'s hot. Wear lightweight, breathable clothes like a t-shirt, shorts, and sandals.';
    }
  }
}



  // init state
  @override
  void initState() {
    super.initState();
     // fetch weather on startup
  _fetchWeather();
   _fetchDailyForecast();
  }


   @override
  Widget build(BuildContext context) {
    String clothingSuggestion = '';

  if (_weather != null) {
    double temperature = _weather!.temperature;
    String mainCondition = _weather!.mainCondition;
    double windSpeed = _weather!.windSpeed;

    clothingSuggestion = getClothingSuggestion(temperature, mainCondition, windSpeed,);
  }else {
    // If _weather is null, you can call getDefaultClothingSuggestion instead
    clothingSuggestion = getDefaultClothingSuggestion(0, '', 0);
  }

     return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: _isSearching
              ? IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      _isSearching = false;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      _isSearching = true;
                    });
                  },
                ),
          title: _isSearching
              ? TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Enter city name',
                  ),
                  onSubmitted: (value) {
                    _fetchWeatherForCity(value);
                  },
                )
              : Text('WeatherPlan'),
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
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Weather'),
              Tab(text: 'Daily Forecast'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_weather?.cityName ?? "loading city.."),
                  Lottie.asset(
                                _weather != null
                                 ? getWeatherAnimation(
                                _weather!.mainCondition,
                                null,
                                isNighttime(_weather!.sunrise, _weather!.sunset),
        )
      : 'assets/sunny.json', // default animation when _weather is null
),
                  Text('${_weather?.temperature.round()}˚F'),
                  const Text('Low-High'),
                  Text(
                    '${_weather?.tempMin.round()}-${_weather?.tempMax.round()}°F',
                  ),
                  Text(_weather?.mainCondition ?? ""),
                  Text('Wind Speed: ${_weather?.windSpeed.round()} MPH'),
                  Text(clothingSuggestion),
                  Container(),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Daily Forecast'),
                  if (_dailyForecast != null)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _dailyForecast!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_dailyForecast![index]),
                        );
                      },
                    )
                  else
                    CircularProgressIndicator(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}