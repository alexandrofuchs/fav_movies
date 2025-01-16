import 'package:fav_movies/core/themes/app_colors.dart';
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
                0.33,
                0.66,
              ],
                  colors: [
                AppColors.primaryColorDark,
                AppColors.primaryColor,
              ])),
          alignment: Alignment.center,
          padding: const EdgeInsets.all(25),
          child: Image.asset(
            'assets/images/app_logo.png',
            width: 250,
            height: 250,
          ).animate().scaleXY(
              begin: 0.3, end: 1, duration: const Duration(milliseconds: 1000)),
        )));
