import 'package:fav_movies/load_environment.dart';
import 'package:fav_movies/root/app_module.dart';
import 'package:fav_movies/root/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    loadAppEnvironment(),
  ]);

  return runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}
