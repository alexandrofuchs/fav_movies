part of 'app_theme.dart';

mixin ThemedComponents {
  static _appBarTheme() => AppBarTheme(
      color: AppColors.primaryColor,
      toolbarHeight: 80,
      titleTextStyle: AppTextStyles.titleLarge.copyWith(
          color: AppColors.secundaryColor, fontWeight: FontWeight.w700));

  static _iconThemeData() =>
      const IconThemeData(color: AppColors.primaryColor, size: 64);
}
