import 'package:flutter/material.dart';

class LocationSearch extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  
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
                  // Optionally trigger an external callback or just handle UI changes
                  print('Search pressed for location: ${_controller.text}');
                },
              ),
            ),
          ),
          // Additional UI components can go here
        ],
      ),
    );
  }
}
