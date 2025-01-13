import 'package:fav_movies/core/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'FAV Movies',
      theme: AppTheme.lightTheme(context),
      routerConfig: Modular.routerConfig,
    );
  }
}
