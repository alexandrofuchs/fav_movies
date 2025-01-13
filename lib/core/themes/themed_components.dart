part of 'app_theme.dart';

mixin ThemedComponents {
  static _appBarTheme() => const AppBarTheme(
      color: AppColors.primaryColor,
      toolbarHeight: 120,
      titleTextStyle: TextStyle(color: AppColors.secundaryColor, fontSize: 32));
}
