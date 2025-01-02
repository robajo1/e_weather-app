import 'package:ethio_weather/model/weather.dart';
import 'package:ethio_weather/permisson/location.dart';
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
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            "Todays Report",
                            style: GoogleFonts.aboreto(
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 0),
                        Padding(
                          padding: const EdgeInsets.only(top: 100),
                          child: Text(
                            "${WeatherData!.sys.country} , ${WeatherData!.name}" ??
                                'Unknown', //city name
                            style: GoogleFonts.agdasima(
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    CheckWeather(),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Text(
                        "Weather Report",
                        style: GoogleFonts.aboreto(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "${(WeatherData!.main.temp - 273.15).toInt() ?? 'N/A'}°C", //temperature
                      style: GoogleFonts.agdasima(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 65,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Lottie.asset(
                              'assets/wind.json',
                              height: 70,
                            ),
                            Text(
                              "${WeatherData!.wind.speed} m/s" ??
                                  'N/A', //wind speed
                              style: GoogleFonts.agdasima(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Lottie.asset(
                              'assets/humidity.json',
                              height: 70,
                            ),
                            Text(
                              "${WeatherData!.main.humidity} %" ??
                                  'N/A', //humidity
                              style: GoogleFonts.agdasima(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Lottie.asset(
                              'assets/pressure.json',
                              height: 50,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${WeatherData!.main.pressure} hPa" ??
                                  'N/A', //pressure
                              style: GoogleFonts.agdasima(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget CheckWeather() {
    if (WeatherData!.weather[0].main == "Clouds") {
      return Lottie.asset(
        'assets/cloud.json',
        height: 350,
      );
    } else if (WeatherData!.weather[0].main == "Rain") {
      return Lottie.asset(
        'assets/rain.json',
        height: 350,
      );
    } else if (WeatherData!.weather[0].main == "Clear") {
      return Lottie.asset(
        'assets/sun.json',
        height: 350,
      );
    } else {
      return Lottie.asset(
        'assets/sun.json',
        height: 350,
      );
    }
  }
}
