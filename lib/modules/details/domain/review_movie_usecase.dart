import 'package:fav_movies/core/common/exceptions/app_exception.dart';
import 'package:fav_movies/core/common/responses/results/i_response/i_response_result.dart';
import 'package:fav_movies/core/common/responses/status/response_status.dart';
import 'package:fav_movies/modules/details/domain/i_repositories/i_review_movie_repository.dart';
import 'package:fav_movies/modules/details/domain/i_usecases/i_review_movie_repository.dart';
import 'package:fav_movies/modules/details/domain/models/movie_review.dart';

class ReviewMovieUsecase implements IReviewMovieUsecase {
  final IReviewMovieRepository _repository;

  ReviewMovieUsecase(this._repository);

  @override
  Future<IResponseResult<ResponseStatus>> saveReview(MovieReview review) async {
    try {
      return Success(await _repository.saveReview(review));
    } catch (e) {
      return Fail(AppException(id: e, method: saveReview, namespace: this));
    }
  }
}
