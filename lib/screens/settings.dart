import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SettingsPage extends StatefulWidget {
  final bool isDarkMode;
  final bool isCelsius;
  final Function(bool, bool) updateSettings;

  SettingsPage({
    required this.isDarkMode,
    required this.isCelsius,
    required this.updateSettings,
  });

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with SingleTickerProviderStateMixin {
  late bool _isDarkMode = false;
  late bool _isCelsius = false;

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode;
    _isCelsius = widget.isCelsius;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('Dark Mode'),
            value: _isDarkMode,
            onChanged: (value) {
              setState(() {
                _isDarkMode = value;
                widget.updateSettings(_isDarkMode, _isCelsius);
              });
            },
          ),
          SwitchListTile(
            title: Text('Temperature Unit'),
            subtitle: Text(_isCelsius ? 'Celsius' : 'Fahrenheit'),
            value: _isCelsius,
            onChanged: (value) {
              setState(() {
                _isCelsius = value;
                widget.updateSettings(_isDarkMode, _isCelsius);
              });
            },
          ),
        ],
      ),
    );
  }
}