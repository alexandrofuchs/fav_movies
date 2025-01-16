import 'package:fav_movies/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

abstract class AppTextStyles {
  static const TextStyle titleSmall = TextStyle(
      fontSize: 16, color: AppColors.primaryColorDark);
  static const TextStyle titleMedium = TextStyle(
      fontSize: 18, color: AppColors.primaryColorDark);
  static const TextStyle titleLarge = TextStyle(
      fontSize: 20, color: AppColors.primaryColorDark);

  static const TextStyle bodySmall =
      TextStyle(fontSize: 12, color: Colors.black);
  static const TextStyle bodyMedium =
      TextStyle(fontSize: 16, color: Colors.black);
  static const TextStyle bodyLarge =
      TextStyle(fontSize: 18, color: Colors.black);

  static const TextStyle labelSmall = TextStyle(
            fontSize: 14,
      color: Colors.white,
      fontWeight: FontWeight.w700);
  static const TextStyle labelMedium = TextStyle(
            fontSize: 18,
      color: Colors.white,
      fontWeight: FontWeight.w700);
  static const TextStyle labelLarge = TextStyle(
            fontSize: 20,
      color: Colors.white,
      fontWeight: FontWeight.w700);
}
