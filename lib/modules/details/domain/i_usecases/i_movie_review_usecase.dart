import 'package:fav_movies/core/common/responses/results/i_response/i_response_result.dart';
import 'package:fav_movies/core/common/responses/status/response_status.dart';
import 'package:fav_movies/modules/details/domain/models/movie_review.dart';

abstract class IMovieReviewUsecase {
  Future<IResponseResult<ResponseStatus>> saveReview(MovieReview review);
  Future<IResponseResult<MovieReview>> getReview(int moveId);
}
