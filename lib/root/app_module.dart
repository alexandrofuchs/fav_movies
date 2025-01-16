import 'package:fav_movies/core/external/api/api_request_interceptor.dart';
import 'package:fav_movies/core/external/api/domain/i_interceptor/i_request_interceptor.dart';
import 'package:fav_movies/core/tools/debouncer/app_debouncer.dart';
import 'package:fav_movies/core/widgets/scaffolds/blocs/bottom_navigator_bloc.dart';
import 'package:fav_movies/data/local_database/load_local_db.dart';
import 'package:fav_movies/modules/details/details_module.dart';
import 'package:fav_movies/modules/favorites/domain/i_repositories/i_load_favorite_movies_repository.dart';
import 'package:fav_movies/modules/favorites/domain/i_usecases/i_load_favorite_movies_usecase.dart';
import 'package:fav_movies/modules/favorites/domain/load_favorite_movies_usecase.dart';
import 'package:fav_movies/modules/favorites/external/load/load_favorite_movies_repository.dart';
import 'package:fav_movies/modules/favorites/favorites_module.dart';
import 'package:fav_movies/modules/favorites/presenter/blocs/load_favorite_movies_bloc.dart';
import 'package:fav_movies/modules/home/domain/favorite_movies_usecase.dart';
import 'package:fav_movies/modules/home/domain/i_repository/i_favorite_movie_repository.dart';
import 'package:fav_movies/modules/home/domain/i_usecase/i_favorite_movie_usecase.dart';
import 'package:fav_movies/modules/home/external/favorite/favorite_movie_repository.dart';
import 'package:fav_movies/modules/home/home_module.dart';
import 'package:fav_movies/modules/home/presenter/bloc/favorite/favorite_movie_bloc.dart';
import 'package:fav_movies/modules/search/search_module.dart';
import 'package:fav_movies/modules/watchlist/watchlist_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sqflite/sqflite.dart';

class AppModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.addLazySingleton<IRequestInterceptor>(ApiRequestInterceptor.new, config: BindConfig(
      onDispose: (value) => value.dispose(),
    ));

    i.addSingleton<BottomNavigatorBloc>(BottomNavigatorBloc.new, config: BindConfig(
      onDispose: (value) => value.close(),
    ));

    i.addSingleton<Database>(() => localDatabase, config: BindConfig(
      onDispose: (value) => value.close(),
    ));


    i.addSingleton<AppDebouncer>(() => AppDebouncer(), config: BindConfig(
      onDispose: (value) => value.dispose(),
    ));


    i.addLazySingleton<IFavoriteMoviesRepository>(FavoriteMoviesRepository.new);
    i.addLazySingleton<IFavoriteMoviesUsecase>(FavoriteMoviesUsecase.new);
    i.addLazySingleton<FavoriteMovieBloc>(FavoriteMovieBloc.new, config: BindConfig(
      onDispose: (value) => value.close(),
    ));

    i.addLazySingleton<ILoadFavoriteMoviesRepository>(LoadFavoriteMoviesRepository.new);
    i.addLazySingleton<ILoadFavoriteMoviesUsecase>(LoadFavoriteMoviesUsecase.new);
    i.addLazySingleton<LoadFavoriteMoviesBloc>(LoadFavoriteMoviesBloc.new, config: BindConfig(
      onDispose: (value) => value.close(),
    ));

    super.exportedBinds(i);
  }

  @override
  void routes(RouteManager r) {
    Modular.setInitialRoute('/home/');

    r.module('/home', module: HomeModule());
    r.module('/favorites', module: FavoritesModule());
    r.module('/watchlist', module: WatchListModule());
    r.module('/search', module: SearchModule());
    r.module('/details', module: DetailsModule());
    super.routes(r);
  }
}
