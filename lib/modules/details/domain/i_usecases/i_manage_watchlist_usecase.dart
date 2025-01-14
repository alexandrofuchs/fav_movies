import 'package:fav_movies/core/common/models/movie.dart';
import 'package:fav_movies/core/common/responses/results/i_response/i_response_result.dart';
import 'package:fav_movies/core/common/responses/status/response_status.dart';

abstract class IManageWatchListUsecase {
  Future<IResponseResult<ResponseStatus>> addMovieToWatchList(Movie movie);
  Future<IResponseResult<ResponseStatus>> removeMovieFromWatchList(int movieId);
  Future<IResponseResult<Movie>> verifyMovieInWatchList(int movieId);
}
