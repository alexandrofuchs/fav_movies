import 'package:fav_movies/core/external/api/domain/i_interceptor/i_request_interceptor.dart';
import 'package:fav_movies/modules/home/domain/i_repository/i_popular_movies_repository.dart';

class PopularMoviesRepository implements IPopularMoviesRepository {
  final IRequestInterceptor _request;

  PopularMoviesRepository(this._request);

  @override
  Future<List<Object>> getMovies() async{
    final response = await _request.get('/movie/popular?language=en-US&page=1');
    return [];
  }
}