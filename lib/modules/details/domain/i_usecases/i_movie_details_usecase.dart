import 'package:fav_movies/core/common/responses/results/i_response/i_response_result.dart';
import 'package:fav_movies/modules/details/domain/models/movie_details.dart';

abstract class IMovieDetailsUsecase {
  Future<IResponseResult<MovieDetails>> getDetails(int movieId);
}