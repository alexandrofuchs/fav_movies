import 'package:fav_movies/modules/details/domain/models/movie_details.dart';

abstract class IMovieDetailsRepository {
  Future<MovieDetails> getDetails(int movieId);
}