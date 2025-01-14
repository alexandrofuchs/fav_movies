import 'package:fav_movies/core/external/api/api_request_interceptor.dart';
import 'package:fav_movies/core/external/api/domain/i_interceptor/i_request_interceptor.dart';
import 'package:fav_movies/core/widgets/scaffolds/blocs/bottom_navigator_bloc.dart';
import 'package:fav_movies/data/local_database/load_local_db.dart';
import 'package:fav_movies/modules/home/home_module.dart';
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

    super.exportedBinds(i);
  }

  @override
  void routes(RouteManager r) {
    Modular.setInitialRoute('/home/');

    r.module('/home', module: HomeModule());
    super.routes(r);
  }
}
