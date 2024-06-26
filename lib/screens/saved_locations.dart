import 'package:flutter/material.dart';

class SavedLocations extends StatelessWidget {
  final VoidCallback onSaveCurrentLocation;
  final List<List<String>> locationsData; // Add this parameter

  SavedLocations({
    required this.onSaveCurrentLocation,
    required this.locationsData, // Update constructor to include locationsData
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[850], // Dark background for the entire widget
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: const Color.fromARGB(255, 67, 67, 67), // Slightly different background color for the header
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Saved Locations',
                  style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                ElevatedButton(
                  onPressed: onSaveCurrentLocation,
                  child: Text('Save Current Location'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF3C89EB), // Button background color
                    foregroundColor: Colors.white, // Button text color
                    elevation: 0, // No shadow for a flatter appearance
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    textStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: locationsData.length, // Update to use locationsData length
              itemBuilder: (context, index) {
                List<String> locationData = locationsData[index];
                String location = locationData[0];
                String temp = locationData[1];
                String description = locationData[2];

                return ListTile(
                  title: Text(
                    location,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.white, // White text color for visibility
                    ),
                  ),
                  subtitle: Text(
                    'Temp: $temp, Condition: $description',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey[400], // Light grey for subtitle
                    ),
                  ),
                  onTap: () {
                    // Action on tap
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
