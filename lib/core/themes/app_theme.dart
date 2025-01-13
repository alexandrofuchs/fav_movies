import 'package:flutter/material.dart';

abstract class AppTheme {
  static lightTheme(BuildContext context) =>
      ThemeData.light(useMaterial3: true).copyWith();
}
