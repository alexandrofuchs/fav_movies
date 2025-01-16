import 'package:fav_movies/core/common/models/movie.dart';

abstract class ILoadFavoriteMoviesRepository {
  Future<List<Movie>> getList();
}