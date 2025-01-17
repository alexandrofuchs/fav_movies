import 'package:fav_movies/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

mixin DefaultAppbarWidgets {
  bottomWidget() => PreferredSize(
      preferredSize: const Size.fromHeight(5),
      child: Container(
        height: 10,
        decoration:
            const BoxDecoration(color: AppColors.primaryColorDark, boxShadow: [
          BoxShadow(
            spreadRadius: 0,
            blurRadius: 1,
            offset: Offset(0, 2),
            color: AppColors.primaryColorLight,
          )
        ]),
      ));
}
