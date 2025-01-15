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

    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const SearchMoviePage(), transition: TransitionType.leftToRightWithFade);
    super.routes(r);
  }
}