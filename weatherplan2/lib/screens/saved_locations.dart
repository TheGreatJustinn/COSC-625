import 'package:flutter/material.dart';

class SavedLocations extends StatelessWidget {
  final VoidCallback onSaveCurrentLocation; // Add this line

  // Update constructor to accept onSaveCurrentLocation
  SavedLocations({required this.onSaveCurrentLocation}); 

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.grey[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Saved Locations',
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              ElevatedButton(
                onPressed: onSaveCurrentLocation,
                child: Text('Save Current Location'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Background color
                  foregroundColor: Colors.white, // Text color
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Expanded(
            child: ListView.builder(
              itemCount: 5, // Replace with the actual number of saved locations
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    'Location ${index + 1}', // Replace with the actual location name
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.black, // Text color of the location name
                    ),
                  ),
                  subtitle: Text(
                    'temp, condition', // Replace with the actual data
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey, // Text color of the coordinates
                    ),
                  ),
                  onTap: () {
                    // Handle tap on a saved location item
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}