import 'package:fav_movies/modules/home/domain/models/popular_movies.dart';

abstract class IPopularMoviesRepository {
  Future<PopularMovies> getMovies(int page);
}