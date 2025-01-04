import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ethio_weather/model/weather.dart';
import 'package:ethio_weather/permisson/location.dart';
import 'package:ethio_weather/weather.dart/pages/currentweather.dart';
import 'package:ethio_weather/weather.dart/pages/search.dart';
import 'package:ethio_weather/weather_service/weather_s.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double? latitude; // To store the latitude
  double? longitude; // To store the longitude
  Weather? WeatherData; // To store the weather data
  bool isLoaded = false; // To show loading indicator

  @override
  void initState() {
    super.initState();
    initialize(); // Call a single initialization method
  }

  Future<void> initialize() async {
    await getlocation();
    await getweather();
    setState(() {
      isLoaded = true;
    });
  }

  Future<void> getlocation() async {
    await locationData();
    setState(() {
      latitude = Data?.latitude;
      longitude = Data?.longitude;
    });
  }

  Future<void> getweather() async {
    WeatherData = await WeatherS().getWeather(latitude, longitude);
  }

  int _selectedindex = 0;
  void _navigateBottomBar(int index) {
    setState(() {
      _selectedindex = index;
    });
  }

  List<Widget> page = [Currentweather(), Search()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 78, 80, 131),
      body: page[_selectedindex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color.fromARGB(255, 78, 80, 131),
        color: Color.fromARGB(255, 24, 26, 64),
        height: 50,
        animationDuration: Duration(milliseconds: 400),
        items: [
          Icon(
            Icons.home,
            color: Color.fromARGB(255, 150, 152, 211),
          ),
          Icon(
            Icons.search,
            color: Color.fromARGB(255, 150, 152, 211),
          ),
        ],
        onTap: (value) {
          _navigateBottomBar(value);
        },
      ),
    );
  }
}
