import 'package:fav_movies/core/splashscreen/app_splash_screen.dart';
import 'package:fav_movies/load_environment.dart';
import 'package:fav_movies/data/local_database/load_local_db.dart';
import 'package:fav_movies/root/app_module.dart';
import 'package:fav_movies/root/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(loadSplashScreen());
  
  await Future.wait([
    loadAppEnvironment(),
    loadLocalDb(),
    Future.delayed(const Duration(milliseconds: 2000))
  ]);

  

  Animate.restartOnHotReload = true;

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  return runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}
