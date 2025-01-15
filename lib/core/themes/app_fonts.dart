import 'package:fav_movies/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

abstract class AppTextStyles {
  static const String fontFamily = 'Krub';

  static const TextStyle titleSmall = TextStyle(
      fontFamily: fontFamily, fontSize: 24, color: AppColors.primaryColor);
  static const TextStyle titleMedium = TextStyle(
      fontFamily: fontFamily, fontSize: 28, color: AppColors.primaryColor);
  static const TextStyle titleLarge = TextStyle(
      fontFamily: fontFamily, fontSize: 32, color: AppColors.primaryColor);

  static const TextStyle bodySmall =
      TextStyle(fontFamily: fontFamily, fontSize: 14, color: Colors.black);
  static const TextStyle bodyMedium =
      TextStyle(fontFamily: fontFamily, fontSize: 18, color: Colors.black);
  static const TextStyle bodyLarge =
      TextStyle(fontFamily: fontFamily, fontSize: 22, color: Colors.black);

  static const TextStyle labelSmall = TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
      color: Colors.white,
      fontWeight: FontWeight.w700);
  static const TextStyle labelMedium = TextStyle(
      fontFamily: fontFamily,
      fontSize: 18,
      color: Colors.white,
      fontWeight: FontWeight.w700);
  static const TextStyle labelLarge = TextStyle(
      fontFamily: fontFamily,
      fontSize: 22,
      color: Colors.white,
      fontWeight: FontWeight.w700);
}
