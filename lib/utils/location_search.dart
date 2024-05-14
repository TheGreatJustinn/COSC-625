import 'package:flutter/material.dart';
import 'handleuserinput.dart'; // Import code from handleuserinput.dart

class LocationSearch extends StatefulWidget {
  final Function(String) onSearch; // Adds the onSearch parameter
  final bool isCelsius; // Add the isCelsius parameter

  LocationSearch({required this.onSearch, required this.isCelsius}); // Constructor

  @override
  _LocationSearchState createState() => _LocationSearchState();
}

class _LocationSearchState extends State<LocationSearch> {
  TextEditingController _controller = TextEditingController(); // Declare TextEditingController
  String _searchedLocation = ''; // Declare searchedLocation variable

  void _searchLocation(String zipCode) async {
  widget.onSearch(zipCode);
  HandleUserInput.handleQuery(zipCode, widget.isCelsius);
  setState(() {
    _searchedLocation = zipCode;
  });
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
        ],
      ),
    );
  }
}