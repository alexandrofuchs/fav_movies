import 'package:fav_movies/modules/details/domain/i_repositories/i_movie_details_repository.dart';
import 'package:fav_movies/modules/details/domain/i_usecases/i_movie_details_usecase.dart';
import 'package:fav_movies/modules/details/domain/movie_details_usecase.dart';
import 'package:fav_movies/modules/details/external/movie_details_repository.dart';
import 'package:fav_movies/modules/details/presenter/pages/movie_details/movie_details_page.dart';
import 'package:fav_movies/root/app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DetailsModule extends Module {
  @override
  List<Module> get imports => [
    AppModule(),
  ];
  
  @override
  void binds(Injector i) {
    i.addLazySingleton<IMovieDetailsRepository>(MovieDetailsRepository.new);
    i.addLazySingleton<IMovieDetailsUsecase>(MovieDetailsUsecase.new);

    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => MovieDetailsPage(movie: r.args.data));
    super.routes(r);
  }
}