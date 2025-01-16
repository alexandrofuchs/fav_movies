import 'package:fav_movies/core/common/models/movie.dart';
import 'package:fav_movies/core/common/responses/results/i_response/i_response_result.dart';

abstract class ISearchMovieUsecase {
  Future<IResponseResult<List<Movie>>> searchMovieByText(String text);
}