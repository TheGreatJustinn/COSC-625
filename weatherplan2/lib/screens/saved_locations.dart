import 'package:flutter/material.dart';

class SavedLocations extends StatelessWidget {
  final VoidCallback onSaveCurrentLocation;

  SavedLocations({required this.onSaveCurrentLocation});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 34, 34, 34), // Dark background for the entire widget
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          _buildLocationList(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [const Color.fromARGB(255, 34, 34, 34), Color.fromARGB(255, 24, 24, 24)],
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 70, 141, 229),
            offset: Offset(0, -10),
            blurRadius: 15.0,
          ),
        ],
      ),
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
              backgroundColor: Color(0xFF3C89EB),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              textStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationList() {
    return Expanded(
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black, Colors.black, Colors.transparent],
            stops: [0.0, .3, 0.95, 1.0],
          ).createShader(bounds);
        },
        blendMode: BlendMode.dstIn,
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                'Location ${index + 1}',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                'temp, condition',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey[400],
                ),
              ),
              onTap: () {
                // Action on tap
              },
            );
          },
        ),
      ),
    );
  }
}
