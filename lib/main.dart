import 'package:flutter/material.dart';
import 'screens/weather_screen.dart';

void main() {
  runApp(MyApp());
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
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light, /* light theme settings */
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark, /* dark theme settings */
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: WeatherScreen(
        isDarkMode: _isDarkMode,
        isCelsius: _isCelsius,
        updateSettings: _updateSettings,
      ),
    );
  }
}