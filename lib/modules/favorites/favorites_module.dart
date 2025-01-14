import 'package:fav_movies/modules/favorites/domain/i_repositories/i_load_favorite_movies_repository.dart';
import 'package:fav_movies/modules/favorites/domain/i_usecases/i_load_favorite_movies_usecase.dart';
import 'package:fav_movies/modules/favorites/domain/load_favorite_movies_usecase.dart';
import 'package:fav_movies/modules/favorites/external/load/load_favorite_movies_repository.dart';
import 'package:fav_movies/modules/favorites/presenter/pages/favorites/favorites_page.dart';
import 'package:fav_movies/root/app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FavoritesModule extends Module {
  
  @override
  List<Module> get imports => [
    AppModule(),
  ];
  
  @override
  void binds(Injector i) {
    i.addLazySingleton<ILoadFavoriteMoviesRepository>(LoadFavoriteMoviesRepository.new);
    i.addLazySingleton<ILoadFavoriteMoviesUsecase>(LoadFavoriteMoviesUsecase.new);

    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const FavoritesPage(), transition: TransitionType.leftToRightWithFade);
    super.routes(r);
  }
}