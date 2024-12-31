import 'dart:math';

import 'package:ethio_weather/permisson/location.dart';
import 'package:ethio_weather/weather.dart/Home.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Intro1 extends StatelessWidget {
  const Intro1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF0B0C1E),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'E-Weather',
              style: TextStyle(
                color: Color.fromARGB(170, 178, 178, 235),
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            Lottie.asset('assets/intro1_animation.json'),
            Text(
              'Discover The Weather In Your City',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(170, 178, 178, 235),
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Get the latest weather updates',
              style: TextStyle(
                color: Color.fromARGB(170, 178, 178, 235),
                fontSize: 14,
              ),
            ),
            SizedBox(height: 50),
            GestureDetector(
              onTap: () async {
                await service();
                if (await permissionGranted()) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home(),
                    ),
                  );
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 90, vertical: 10),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 5, 5, 206),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Get Started',
                  style: TextStyle(
                    color: Color.fromARGB(170, 178, 178, 235),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
