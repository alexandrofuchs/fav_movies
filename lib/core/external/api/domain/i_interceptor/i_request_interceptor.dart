abstract class IRequestInterceptor {
  Future<dynamic> get(String path, {Object? data});
  Future<dynamic> put(String path, {Object? data});
  Future<dynamic> post(String path, {Object? data});
}