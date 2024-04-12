import 'package:flutter/material.dart';
import 'package:new_weather/pages/weather_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  
@override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;
  bool _isCelsius = true;

  void _updateSettings(bool isDarkMode, bool isCelsius) {
    setState(() {
      _isDarkMode = isDarkMode;
      _isCelsius = isCelsius;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        /* light theme settings */
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        /* dark theme settings */
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: WeatherPage(
        isDarkMode: _isDarkMode,
        isCelsius: _isCelsius,
        updateSettings: _updateSettings,
      ),
      debugShowCheckedModeBanner: false,
    );

  }
}