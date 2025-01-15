import 'package:fav_movies/modules/favorites/presenter/pages/favorites/favorites_page.dart';
import 'package:fav_movies/root/app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FavoritesModule extends Module {
  
  @override
  List<Module> get imports => [
    AppModule(),
  ];

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const FavoritesPage(), transition: TransitionType.leftToRightWithFade);
    super.routes(r);
  }
}