import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_weather/models/clothing.dart';
import 'package:shared_preferences/shared_preferences.dart';



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
  //late TabController _tabController;
  late bool _isDarkMode = false;
  late bool _isCelsius = true;
  Clothing _clothing = Clothing();
   bool _isSleeveless = false;
  bool _isShortSleeves = false;
  bool _isLongSleeves = false;
  bool _isSweater = false;
  bool _isJacketCoat = false;

  @override
  void initState() {
    super.initState();
    //_tabController = TabController(length: 2, vsync: this);
    _isDarkMode = widget.isDarkMode;
    _isCelsius = widget.isCelsius;
   _loadClothingPreferences();
  }

  void _loadClothingPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _clothing = Clothing(
        sleeveless: prefs.getBool('sleeveless') ?? false,
        shortSleeves: prefs.getBool('shortSleeves') ?? false,
        longSleeves: prefs.getBool('longSleeves') ?? false,
        sweater: prefs.getBool('sweater') ?? false,
        jacketCoat: prefs.getBool('jacketCoat') ?? false,
      );
    });
  }

  void _saveClothingPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('sleeveless', _clothing.sleeveless);
    await prefs.setBool('shortSleeves', _clothing.shortSleeves);
    await prefs.setBool('longSleeves', _clothing.longSleeves);
    await prefs.setBool('sweater', _clothing.sweater);
    await prefs.setBool('jacketCoat', _clothing.jacketCoat);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Clothing Suggestions'),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Clothing Suggestions'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SwitchListTile(
                        title: Text('Sleeveless'),
                        value: _isSleeveless,
                        onChanged: (value) {
                          setState(() {
                            _isSleeveless = value;
                            _saveClothingPreferences();
                          });
                        },
                      ),
                      SwitchListTile(
                        title: Text('Short Sleeves'),
                        value: _isShortSleeves,
                        onChanged: (value) {
                          setState(() {
                            _isShortSleeves = value;
                            _saveClothingPreferences();
                          });
                        },
                      ),
                      SwitchListTile(
                        title: Text('Long Sleeves'),
                        value: _isLongSleeves,
                        onChanged: (value) {
                          setState(() {
                            _isLongSleeves = value;
                            _saveClothingPreferences();
                          });
                        },
                      ),
                      SwitchListTile(
                        title: Text('Sweater'),
                        value: _isSweater,
                        onChanged: (value) {
                          setState(() {
                            _isSweater = value;
                            _saveClothingPreferences();
                          });
                        },
                      ),
                      SwitchListTile(
                        title: Text('Jacket/Coat'),
                        value: _isJacketCoat,
                        onChanged: (value) {
                          setState(() {
                            _isJacketCoat = value;
                            _saveClothingPreferences();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
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