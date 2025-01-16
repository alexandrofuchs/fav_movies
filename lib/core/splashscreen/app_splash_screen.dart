import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

MaterialApp loadSplashScreen() => MaterialApp(
    builder: (context, child) => Scaffold(
            body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [
                0.22,
                0.55,
                1
              ],
                  colors: [
                Color(0xffF1E4E4),
                Color(0xffB4A8A8),
                Color(0xff3E3333),
              ])),
          alignment: Alignment.center,
          padding: const EdgeInsets.all(25),
          child: Image.asset('assets/images/app_logo.png').animate().scaleXY(
              begin: 0.3, end: 1, duration: const Duration(milliseconds: 1000)),
        )));
