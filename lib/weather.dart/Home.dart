import 'package:ethio_weather/model/weather.dart';
import 'package:ethio_weather/permisson/location.dart';
import 'package:ethio_weather/weather_service/weather_s.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
    await getlocation(); // Ensure location data is fetched first
    await getweather(); // Fetch weather after location data is ready
    setState(() {
      isLoaded = true; // Update the state after everything is loaded
    });
  }

  Future<void> getlocation() async {
    await locationData(); // Fetch location data
    setState(() {
      latitude = Data?.latitude; // Extract latitude
      longitude = Data?.longitude; // Extract longitude
    });
  }

  Future<void> getweather() async {
    WeatherData = await WeatherS().getWeather(latitude, longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: Color(0xFF0B0C1E),
        body: Center(
          child: latitude == null ||
                  longitude == null ||
                  !isLoaded // Check if lat and long are available
              ? CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Todays Report",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(width: 23),
                        Text(
                          WeatherData?.name ?? 'Unknown', //city name
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Lottie.asset('assets/sun.json'),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Text(
                        "Weather Report",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "${WeatherData?.main?.temp ?? 'N/A'}°C", //temperature
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Lottie.asset(
                          'assets/wind.json',
                          height: 70,
                        ),
                        Lottie.asset('assets/humidity.json', height: 100),
                      ],
                    ),
                  ],
                ), // Show the location once data is available
        ),
      ),
    );
  }
}
