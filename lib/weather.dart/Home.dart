import 'package:ethio_weather/permisson/location.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double? latitude; // To store the latitude
  double? longitude; // To store the longitude

  @override
  void initState() {
    super.initState();
    getlocation(); // Call getlocation when widget is initialized
  }

  // Method to fetch location, extract lat and long, and update the UI
  Future<void> getlocation() async {
    await locationData(); // Fetch location data
    setState(() {
      latitude = Data?.latitude; // Extract latitude
      longitude = Data?.longitude;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: Color(0xFF0B0C1E),
        body: Center(
          child: latitude == null ||
                  longitude == null // Check if lat and long are available
              ? CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Latitude: $latitude",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "Longitude: $longitude",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ), // Show the location once data is available
        ),
      ),
    );
  }
}
