import 'package:fav_movies/core/external/api/api_request_interceptor.dart';
import 'package:fav_movies/core/external/api/domain/i_interceptor/i_request_interceptor.dart';
import 'package:fav_movies/modules/home/home_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.addLazySingleton<IRequestInterceptor>(ApiRequestInterceptor.new);
    super.exportedBinds(i);
  }

  @override
  void routes(RouteManager r) {
    Modular.setInitialRoute('/home/');

    r.module('/home', module: HomeModule());
    super.routes(r);
  }
}
