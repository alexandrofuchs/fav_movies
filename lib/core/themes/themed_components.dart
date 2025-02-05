part of 'app_theme.dart';

mixin ThemedComponents {
  static _appBarTheme() => AppBarTheme(
      color: AppColors.primaryColorDark,
      toolbarHeight: 75,
      elevation: 0,
      shape: const Border(bottom: BorderSide(color: AppColors.orangeColor, width: 0.5)),
      iconTheme: const IconThemeData(
        size: 24,
        color: AppColors.orangeColor
      ),
      titleTextStyle: AppTextStyles.titleLarge.copyWith(
          color: AppColors.secundaryColor, fontWeight: FontWeight.w700));

  static _iconThemeData() =>
      const IconThemeData(color: AppColors.orangeColor, size: 64);
}
