import 'package:fav_movies/core/common/exceptions/app_exception.dart';
import 'package:fav_movies/core/common/responses/results/i_response/i_response_result.dart';
import 'package:fav_movies/core/common/responses/status/response_status.dart';
import 'package:fav_movies/modules/details/domain/i_repositories/i_movie_review_repository.dart';
import 'package:fav_movies/modules/details/domain/i_usecases/i_movie_review_usecase.dart';
import 'package:fav_movies/modules/details/domain/models/movie_review.dart';

class MovieReviewUsecase implements IMovieReviewUsecase {
  final IMovieReviewRepository _repository;

  MovieReviewUsecase(this._repository);

  @override
  Future<IResponseResult<ResponseStatus>> saveReview(MovieReview review) async {
    try {
      return Success(await _repository.saveReview(review));
    } catch (e) {
      return Fail(AppException(id: e, method: saveReview, namespace: this));
    }
  }
  
  @override
  Future<IResponseResult<MovieReview>> getReview(int moveId) async {
    try {
      return Success(await _repository.getReview(moveId));
    } catch (e) {
      return Fail(AppException(id: e, method: getReview, namespace: this));
    }
  }
}
