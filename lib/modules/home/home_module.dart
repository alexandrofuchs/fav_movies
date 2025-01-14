import 'package:fav_movies/modules/home/domain/favorite_movies_usecase.dart';
import 'package:fav_movies/modules/home/domain/i_repository/i_favorite_movie_repository.dart';
import 'package:fav_movies/modules/home/domain/i_repository/i_popular_movies_repository.dart';
import 'package:fav_movies/modules/home/domain/i_usecase/i_favorite_movie_usecase.dart';
import 'package:fav_movies/modules/home/domain/i_usecase/i_popular_movies_usecase.dart';
import 'package:fav_movies/modules/home/domain/popular_movies_usecase.dart';
import 'package:fav_movies/modules/home/external/favorite/favorite_movie_repository.dart';
import 'package:fav_movies/modules/home/external/popular/popular_movies_repository.dart';
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
    i.addLazySingleton<IPopularMoviesRepository>(PopularMoviesRepository.new);
    i.addLazySingleton<IPopularMoviesUsecase>(PopularMoviesUsecase.new);

    i.addLazySingleton<IFavoriteMoviesRepository>(FavoriteMoviesRepository.new);
    i.addLazySingleton<IFavoriteMoviesUsecase>(FavoriteMoviesUsecase.new);

    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const PopularMoviesPage());
    super.routes(r);
  }
}
