import 'package:ethio_weather/model/weather.dart';
import 'package:ethio_weather/weather.dart/pages/currentweather.dart';
import 'package:ethio_weather/weather_service/weather_s.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Search extends StatefulWidget {
  Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  //LatLng? _selectedLocation;
  Location? _selectedLocation;
  Weather? _selectedWeatherData;
  bool isLoaded = false;
  String _searcherror = 'please search for a city or country';
  String? cityname;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: TextField(
                onSubmitted: (value) async {
                  await getCityCoordinates(value);
                  await getweather();
                  setState(() {
                    isLoaded = true;
                  });
                },
                onChanged: (value) async => {
                  setState(() {
                    cityname = value;
                  })
                },
                decoration: InputDecoration(
                  hintText: 'Enter a city or country',
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Roboto', // Specify your desired font family
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () async {
                      await getCityCoordinates(cityname!);
                      await getweather();
                      setState(() {
                        isLoaded = true;
                      });
                    },
                    icon: Icon(Icons.search, color: Colors.white),
                  ),
                ),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Roboto', // Specify your desired font family
                ),
              ),
            ),
          ),
          isLoaded && _selectedLocation != null
              ? Expanded(
                  flex: 2,
                  child: selectedLocationUI(),
                )
              : Expanded(
                  flex: 2,
                  child: Container(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        _searcherror,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget selectedLocationUI() {
    return SizedBox(
      width: double.infinity,
      child: Center(
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 1),
                    child: Text(
                      "Todays Report",
                      style: GoogleFonts.aboreto(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 0),
                  Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Text(
                      "${_selectedWeatherData!.sys.country} , ${_selectedWeatherData!.name}" ??
                          'Unknown', //city name
                      style: GoogleFonts.agdasima(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: CheckWeather(_selectedWeatherData)),
            Text(
              "Weather Report",
              style: GoogleFonts.aboreto(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "${(_selectedWeatherData!.main.temp - 273.15).toInt() ?? 'N/A'}°C", //temperature
              style: GoogleFonts.agdasima(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 65,
                ),
              ),
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
                      "${_selectedWeatherData!.wind.speed} m/s" ??
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
                      "${_selectedWeatherData!.main.humidity} %" ??
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
              ],
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getweather() async {
    _selectedWeatherData = await WeatherS()
        .getWeather(_selectedLocation?.latitude, _selectedLocation?.longitude);
  }

  Future<void> getCityCoordinates(String cityName) async {
    //get the coordinates of the city that doesn't exist is not showing any error message
    List<Location> locations = await locationFromAddress(cityName);
    if (locations.isEmpty) {
      setState(() {
        _searcherror = 'An error occurred while searching for $cityName';
      });
      return;
    }
    if (locations.isNotEmpty) {
      setState(() {
        _selectedLocation = locations[0];
      });
    } else {
      setState(() {
        _searcherror = 'No location found for $cityName';
      });
    }
  }
}
