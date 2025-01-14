import 'package:fav_movies/core/common/exceptions/app_exception.dart';
import 'package:fav_movies/core/common/models/models/movie.dart';
import 'package:fav_movies/core/common/responses/results/i_response/i_response_result.dart';
import 'package:fav_movies/core/common/responses/status/response_status.dart';
import 'package:fav_movies/modules/home/domain/i_repository/i_favorite_movie_repository.dart';
import 'package:fav_movies/modules/home/domain/i_usecase/i_favorite_movie_usecase.dart';

class FavoriteMoviesUsecase implements IFavoriteMoviesUsecase {
  final IFavoriteMoviesRepository _repository;

  FavoriteMoviesUsecase(this._repository);

  @override
  Future<IResponseResult<ResponseStatus>> save(Movie movie) async {
    try {
      return Success(await _repository.save(movie));
    } catch (e) {
      return Fail(AppException(id: e, method: save, namespace: this));
    }
  }
}
