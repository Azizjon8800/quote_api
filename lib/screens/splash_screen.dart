import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quoteapp_api/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer1;
  late Timer _timer2;
  late Timer _timer3;
  double _scale = 0.0;
  bool isVisible = false;

  @override
  void initState() {
    super.initState();

    _timer1 = Timer(Duration(seconds: 1), () {
      setState(() {
        _scale = _scale == 0.0 ? 1 : 0;
      });
    });

    _timer2 = Timer(Duration(milliseconds: 1800), () {
      setState(() {
        isVisible = !isVisible;
      });
    });

    _timer3 = Timer(Duration(milliseconds: 2300), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _timer1.cancel();
    _timer2.cancel();
    _timer3.cancel();
    super.dispose();
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
              duration: Duration(milliseconds: 500),
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