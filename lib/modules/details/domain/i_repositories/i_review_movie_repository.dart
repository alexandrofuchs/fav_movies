import 'package:fav_movies/core/common/responses/status/response_status.dart';
import 'package:fav_movies/modules/details/domain/models/movie_review.dart';

abstract class IReviewMovieRepository {
  Future<ResponseStatus> saveReview(MovieReview review);
}
