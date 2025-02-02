part of 'app_theme.dart';

mixin ThemedComponents {
  static _appBarTheme() => AppBarTheme(
      color: AppColors.primaryColorDark,
      toolbarHeight: 75,
      elevation: 0,
      shape: const Border(bottom: BorderSide(color: AppColors.secundaryColor, width: 0.25)),
      iconTheme: const IconThemeData(
        size: 24,
        color: AppColors.secundaryColor
      ),
      titleTextStyle: AppTextStyles.titleLarge.copyWith(
          color: AppColors.secundaryColor, fontWeight: FontWeight.w700));

  static _iconThemeData() =>
      const IconThemeData(color: AppColors.primaryColor, size: 64);
}
