import 'package:fav_movies/modules/home/domain/favorite_movies_usecase.dart';
import 'package:fav_movies/modules/home/domain/i_repository/i_favorite_movie_repository.dart';
import 'package:fav_movies/modules/home/domain/i_usecase/i_favorite_movie_usecase.dart';
import 'package:fav_movies/modules/home/external/favorite/favorite_movie_repository.dart';
import 'package:fav_movies/modules/search/domain/i_repositories/i_search_movie_repository.dart';
import 'package:fav_movies/modules/search/domain/i_usecases/i_search_movie_usecase.dart';
import 'package:fav_movies/modules/search/domain/search_movie_usecase.dart';
import 'package:fav_movies/modules/search/external/search_movie_repository.dart';
import 'package:fav_movies/modules/search/presenter/pages/search_movie/search_movie_page.dart';
import 'package:fav_movies/root/app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SearchModule extends Module {
  
  @override
  List<Module> get imports => [
    AppModule(),
  ];
  
  @override
  void binds(Injector i) {
    i.addLazySingleton<ISearchMovieRepository>(SearchMovieRepository.new);
    i.addLazySingleton<ISearchMovieUsecase>(SearchMovieUsecase.new);

    
    i.addLazySingleton<IFavoriteMoviesRepository>(FavoriteMoviesRepository.new);
    i.addLazySingleton<IFavoriteMoviesUsecase>(FavoriteMoviesUsecase.new);

    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const SearchMoviePage());
    super.routes(r);
  }
}