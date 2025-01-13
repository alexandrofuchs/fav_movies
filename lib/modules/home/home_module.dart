import 'package:fav_movies/modules/home/presenter/pages/popular_movies/popular_movies_page.dart';
import 'package:fav_movies/root/app_module.dart';
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
    r.child('/', child: (context) => const PopularMoviesPage());
    super.routes(r);
  }
}
