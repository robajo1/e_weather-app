import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Intro2 extends StatelessWidget {
  const Intro2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF0B0C1E),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Allow location permission to continue',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(170, 178, 178, 235),
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
            Lottie.asset('assets/intro2_animation.json'),
            SizedBox(height: 50),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Color.fromARGB(170, 30, 30, 65),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Allow Location',
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
