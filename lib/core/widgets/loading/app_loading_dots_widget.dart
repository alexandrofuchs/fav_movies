import 'dart:async';

import 'package:fav_movies/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class AppLoadingDots extends StatefulWidget {
  final Size dotSize;
  final Color color;
  const AppLoadingDots(
      {super.key,
      this.dotSize = const Size(14, 14),
      this.color = AppColors.secundaryColor});

  @override
  State<StatefulWidget> createState() => _AppLoadingDotsState();
}

class _AppLoadingDotsState extends State<AppLoadingDots> {
  Timer timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {});

  double dot1 = 1;
  double dot2 = 1;
  double dot3 = 1;

  int counter = 0;

  @override
  void initState() {
    changeSize();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Widget circle() {
    return Center(
        child: Container(
            height: widget.dotSize.height,
            width: widget.dotSize.width,
            
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: widget.color,
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 5,
                    spreadRadius: 2,
                    color: AppColors.secundaryColor,
                  )
                ]
                
                )));
  }

  void changeSize() {
    timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        if (counter == 0) {
          dot1 = 2;
          dot2 = dot3 = 1;
        } else if (counter == 1) {
          dot2 = 2;
          dot1 = dot3 = 1;
        } else if (counter == 2) {
          dot3 = 2;
          dot1 = dot2 = 1;
        }
        counter++;
        if (counter > 2) {
          counter = 0;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) => Container(
    alignment: Alignment.center,
      color: AppColors.primaryColorDark,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TweenAnimationBuilder(
              tween: Tween(
                begin: 0,
                end: dot1,
              ),
              duration: const Duration(milliseconds: 500),
              builder: (context, value, child) =>
                  Transform.scale(scale: value.toDouble(), child: child),
              child: circle(),
            ),
            Container(width: 25),
            TweenAnimationBuilder(
              tween: Tween(
                begin: 0,
                end: dot2,
              ),
              duration: const Duration(milliseconds: 500),
              builder: (context, value, child) =>
                  Transform.scale(scale: value.toDouble(), child: child),
              child: circle(),
            ),
            Container(width: 25),
            TweenAnimationBuilder(
              tween: Tween(
                begin: 0,
                end: dot3,
              ),
              duration: const Duration(milliseconds: 500),
              builder: (context, value, child) =>
                  Transform.scale(scale: value.toDouble(), child: child),
              child: circle(),
            ),
          ],
        ),
      );
}
