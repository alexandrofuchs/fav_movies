import 'package:fav_movies/core/common/responses/status/response_status.dart';
import 'package:fav_movies/modules/home/domain/models/movie.dart';

abstract class IFavoriteMoviesRepository {
  Future<ResponseStatus> save(Movie movie);
}