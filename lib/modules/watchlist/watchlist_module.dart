import 'package:fav_movies/modules/watchlist/domain/i_repositories/i_load_watchlist_repository.dart';
import 'package:fav_movies/modules/watchlist/domain/i_usecases/i_load_watchlist_usecase.dart';
import 'package:fav_movies/modules/watchlist/domain/load_watchlist_usecase.dart';
import 'package:fav_movies/modules/watchlist/external/load/load_watchlist_repository.dart';
import 'package:fav_movies/modules/watchlist/presenter/pages/favorites/watchlist_page.dart';
import 'package:fav_movies/root/app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class WatchListModule extends Module {
  
  @override
  List<Module> get imports => [
    AppModule(),
  ];
  
  @override
  void binds(Injector i) {
    i.addLazySingleton<ILoadWatchListRepository>(LoadWatchListRepository.new);
    i.addLazySingleton<ILoadWatchListUsecase>(LoadWatchListUsecase.new);

    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const WatchListPage(), transition: TransitionType.fadeIn);
    super.routes(r);
  }
}

