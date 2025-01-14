import 'package:fav_movies/core/common/models/models/movie.dart';
import 'package:fav_movies/core/common/responses/results/i_response/i_response_result.dart';
import 'package:fav_movies/core/common/responses/status/response_status.dart';

abstract class IFavoriteMoviesUsecase {
  Future<IResponseResult<ResponseStatus>> save(Movie movie);
}