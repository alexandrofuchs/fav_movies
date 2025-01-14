import 'package:fav_movies/core/common/models/movie.dart';

abstract class ILoadWatchListRepository {
  Future<List<Movie>> getList();
}