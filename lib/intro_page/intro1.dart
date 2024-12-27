import 'dart:math';

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
          ],
        ),
      ),
    );
  }
}
