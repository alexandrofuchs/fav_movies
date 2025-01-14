import 'package:fav_movies/core/common/responses/results/i_response/i_response_result.dart';
import 'package:fav_movies/core/common/responses/status/response_status.dart';
import 'package:fav_movies/modules/home/domain/models/movie.dart';

abstract class IFavoriteMoviesUsecase {
  Future<IResponseResult<ResponseStatus>> save(Movie movie);
}