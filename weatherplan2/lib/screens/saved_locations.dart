import 'package:flutter/material.dart';

class SavedLocations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.grey[200], // Background color of the saved locations section
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Saved Locations',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.blue, // Text color of the section title
            ),
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
