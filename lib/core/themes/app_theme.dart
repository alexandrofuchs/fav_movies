import 'package:fav_movies/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

part 'themed_components.dart';

abstract class AppTheme with ThemedComponents {
  static lightTheme(BuildContext context) =>
      ThemeData.light(useMaterial3: true).copyWith(
          primaryColor: AppColors.primaryColor,
          primaryColorLight: AppColors.primaryColorLight,
          appBarTheme: ThemedComponents._appBarTheme());
}
