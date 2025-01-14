import 'package:fav_movies/core/common/models/models/movie.dart';
import 'package:fav_movies/core/common/responses/status/response_status.dart';

abstract class IFavoriteMoviesRepository {
  Future<ResponseStatus> save(Movie movie);
}