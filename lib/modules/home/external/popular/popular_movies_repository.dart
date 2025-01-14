import 'package:fav_movies/core/external/api/domain/i_interceptor/i_request_interceptor.dart';
import 'package:fav_movies/modules/home/domain/i_repository/i_popular_movies_repository.dart';
import 'package:fav_movies/modules/home/domain/models/movie.dart';
import 'package:fav_movies/modules/home/domain/models/popular_movies.dart';

part 'popular_movie_model.dart';

class PopularMoviesRepository implements IPopularMoviesRepository {
  final IRequestInterceptor _request;

  PopularMoviesRepository(this._request);

  @override
  Future<PopularMovies> getMovies(int page) async{
    final response = await _request.get('/movie/popular?language=pt-BR&page=$page');
    return PopularMoviesModel.fromMap(response);
  }
}