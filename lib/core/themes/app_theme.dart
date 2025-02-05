import 'package:fav_movies/core/themes/app_colors.dart';
import 'package:fav_movies/core/themes/app_fonts.dart';
import 'package:flutter/material.dart';

part 'themed_components.dart';

abstract class AppTheme with ThemedComponents {
  static lightTheme(BuildContext context) =>
      ThemeData.light(useMaterial3: false).copyWith(
          primaryColor: AppColors.primaryColor,
          primaryColorLight: AppColors.primaryColorLight,
          scaffoldBackgroundColor: AppColors.brandColor,
          appBarTheme: ThemedComponents._appBarTheme(),
          iconTheme: ThemedComponents._iconThemeData(),
          navigationBarTheme: NavigationBarTheme.of(context).copyWith(
            backgroundColor: AppColors.primaryColorDark,
            elevation: 1,
            overlayColor:
                const WidgetStatePropertyAll(AppColors.orangeColor),
            indicatorColor: AppColors.primaryColor,
            labelTextStyle:  WidgetStatePropertyAll(
                AppTextStyles.labelSmall.copyWith(color: AppColors.orangeColor)),
            iconTheme: const WidgetStatePropertyAll(
              IconThemeData(size: 24, color: AppColors.orangeColor)),
            indicatorShape: const Border(

                top: BorderSide(color: AppColors.orangeColor, width: 0.25))),
          textTheme:  const TextTheme(
            titleLarge: AppTextStyles.titleLarge,
            titleMedium: AppTextStyles.titleMedium,
            titleSmall: AppTextStyles.titleSmall,
            bodyLarge: AppTextStyles.bodyLarge,
            bodyMedium: AppTextStyles.bodyMedium,
            bodySmall: AppTextStyles.bodySmall,
            displayLarge: AppTextStyles.titleLarge,
            displayMedium: AppTextStyles.titleMedium,
            displaySmall: AppTextStyles.titleSmall,
            labelLarge: AppTextStyles.labelLarge,
            labelMedium: AppTextStyles.labelMedium,
            labelSmall: AppTextStyles.labelSmall,

          ),
          

      );
}
