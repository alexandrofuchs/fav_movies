import 'package:fav_movies/core/common/responses/i_response/i_response_result.dart';
import 'package:fav_movies/modules/home/domain/models/popular_movies.dart';

abstract class IPopularMoviesUsecase {
  Future<IResponseResult<PopularMovies>> getMovies(int page);
}