import 'package:fav_movies/core/common/exceptions/app_exception.dart';
import 'package:fav_movies/core/common/responses/results/i_response/i_response_result.dart';
import 'package:fav_movies/modules/details/domain/i_repositories/i_movie_details_repository.dart';
import 'package:fav_movies/modules/details/domain/i_usecases/i_movie_details_usecase.dart';
import 'package:fav_movies/modules/details/domain/models/movie_details.dart';

class MovieDetailsUsecase implements IMovieDetailsUsecase {
  final IMovieDetailsRepository _repository;

  MovieDetailsUsecase(this._repository);

  @override
  Future<IResponseResult<MovieDetails>> getDetails(int movieId) async {
    try {
      return Success(await _repository.getDetails(movieId));
    } catch (e) {
      return Fail(AppException(id: e, method: getDetails, namespace: this));
    }
  }
}
