import 'package:flutter/material.dart';

class LocationSearch extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0), // Padding around the outer Material
      child: Material(
        elevation: 4.0, // Adds shadow below the Material
        borderRadius: BorderRadius.circular(8.0), // Rounded corners for aesthetic
        child: Container(
          // Keep padding symmetric, adjust if necessary
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5), // Semi-transparent white background
            borderRadius: BorderRadius.circular(8.0), // Rounded corners
          ),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Enter location',
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  // Trigger a UI update or callback
                  print('Search pressed for location: ${_controller.text}');
                },
              ),
              border: InputBorder.none, // Removes underline from the TextField
              contentPadding: EdgeInsets.symmetric(vertical: 10), // Adjust vertical padding to center text
              filled: false, // No fill color
            ),
          ),
        ),
      ),
    );
  }
}