import 'dart:math';

import 'package:ethio_weather/permisson/location.dart';
import 'package:ethio_weather/weather.dart/Home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Intro1 extends StatelessWidget {
  const Intro1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 47, 48, 74),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'E-Weather',
              style: GoogleFonts.aboreto(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                ),
              ),
            ),
            Lottie.asset('assets/intro1_animation.json'),
            Text(
              'Discover The Weather In Your City',
              textAlign: TextAlign.center,
              style: GoogleFonts.aboreto(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Get the latest weather updates',
              style: GoogleFonts.aboreto(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
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
                  color: Color.fromARGB(255, 78, 80, 131),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Get Started',
                  style: GoogleFonts.aboreto(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
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
