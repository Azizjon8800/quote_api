import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quoteapp_api/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _scale = 0.0;
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1) , () {
      setState(() {
        _scale = _scale == 0.0 ? 1 : 0;
      });
    });
    Timer(const Duration(milliseconds: 1800), () {
      setState(() {
        isVisible = !isVisible;
      });
    });

    Timer(const Duration(milliseconds: 2300), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedScale(
              duration: const Duration(seconds: 1),
              scale: _scale,
              child: Image.asset(
                'assets/images/quote.png',
                height: 300,
                width: 300,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            AnimatedOpacity(
              duration: Duration(milliseconds: 1800),
              opacity: isVisible ? 1 : 0,
              child: const Text(
                'Quotes',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}