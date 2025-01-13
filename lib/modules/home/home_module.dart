import 'package:fav_movies/root/app_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  List<Module> get imports => [
        AppModule(),
      ];

  @override
  void binds(Injector i) {
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child('/',
        child: (context) => Scaffold(
              appBar: AppBar(
                  backgroundColor: Colors.black,
                  toolbarHeight: 50,
                  title: const Text(
                    'App Module',
                    style: TextStyle(color: Colors.white),
                  )),
            ));
    super.routes(r);
  }
}
