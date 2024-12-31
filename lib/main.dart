import 'package:ethio_weather/intro_page/intro1.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  runApp(
    MaterialApp(
      home: Weather(),
    ),
  );
}

class Weather extends StatefulWidget {
  const Weather({super.key});

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: [
              Intro1(),
            ],
          ),
          Container(
            //we can use bottomsheet for the skip and next button
            //we can use navigator.pushreplacement to go to home page after the intro what navigator.pushreplacement does is it will remove the intro page from the stack and replace it with the home page
            alignment: Alignment(0, 0.9),
            child: SmoothPageIndicator(
              effect: JumpingDotEffect(
                verticalOffset: 10,
              ),
              controller: _pageController,
              count: 1,
            ),
          ),
        ],
      ),
    );
  }
}
