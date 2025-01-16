import 'package:fav_movies/core/common/models/movie.dart';
import 'package:fav_movies/core/common/responses/status/response_status.dart';

abstract class IManageWatchListRepository {
  Future<ResponseStatus> addToWatchList(Movie movie);
  Future<ResponseStatus> removeFromWatchList(int movieId);
  Future<Movie> verifyMovieInWatchList(int movieId);
}
