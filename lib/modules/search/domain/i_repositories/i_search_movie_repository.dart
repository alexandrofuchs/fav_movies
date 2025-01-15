import 'package:fav_movies/core/common/models/movie.dart';

abstract class ISearchMovieRepository {
  Future<List<Movie>> searchMovieByText(String text);
}