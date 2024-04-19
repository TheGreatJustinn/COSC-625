import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LocationSearch extends StatefulWidget {
  @override
  _LocationSearchState createState() => _LocationSearchState();
}

class _LocationSearchState extends State<LocationSearch> {
  TextEditingController _controller = TextEditingController();
  String _searchedLocation = '';
  double _latitude = 0.0;
  double _longitude = 0.0;

  void _searchLocation(String query) async {
    // Replace 'YOUR_API_KEY' with your actual API key
     
    final apiKey = 'YOUR_GEOCODING_API_KEY';
    final url = 'GET_LOCATION_COORDINATES';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'];
      
      if (results.isNotEmpty) {
        final location = results[0]['geometry']['location'];
        final latitude = location['lat'];
        final longitude = location['lng'];
        
        setState(() {
          _searchedLocation = query;
          _latitude = latitude;
          _longitude = longitude;
        });

        // Check if the searched location already exists in the saved locations
        bool locationExists = _checkLocationExists(query);

        // Show dialog box to ask user if they want to save the location
        if (!locationExists) {
          _showSaveLocationDialog(query, latitude, longitude);
        }
      } else {
        print('No results found for the given location.');
      }
    } else {
      print('Failed to fetch data: ${response.reasonPhrase}');
    }
  }

  bool _checkLocationExists(String query) {
    // Implement logic to check if the searched location already exists in the saved locations
    // For simplicity, let's assume a list of saved locations called savedLocations
    // You can replace this with your actual implementation
    List<String> savedLocations = ['New York, NY', 'Los Angeles, CA', 'Chicago, IL']; // Example list of saved locations
    return savedLocations.contains(query);
  }

  void _showSaveLocationDialog(String query, double latitude, double longitude) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Save Location'),
          content: Text('Do you want to save $query to your list of saved locations?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                // Save the location to the list of saved locations
                _saveLocation(query, latitude, longitude);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _saveLocation(String query, double latitude, double longitude) {
    // Implement saving the location to the list of saved locations
    // You can use a data structure like a list or a database to store the saved locations
    // For simplicity, let's print the location details
    print('Location saved: $query, Latitude: $latitude, Longitude: $longitude');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Enter location',
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  _searchLocation(_controller.text);
                },
              ),
            ),
          ),
          SizedBox(height: 20),
          if (_searchedLocation.isNotEmpty)
            Text(
              'Searched Location: $_searchedLocation',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          if (_latitude != 0.0 && _longitude != 0.0)
            Text(
              'Latitude: $_latitude, Longitude: $_longitude',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
        ],
      ),
    );
  }
}
