import 'package:fav_movies/core/common/exceptions/app_exception.dart';
import 'package:fav_movies/core/common/models/movie.dart';
import 'package:fav_movies/core/common/responses/results/i_response/i_response_result.dart';
import 'package:fav_movies/modules/favorites/domain/i_repositories/i_load_favorite_movies_repository.dart';
import 'package:fav_movies/modules/favorites/domain/i_usecases/i_load_favorite_movies_usecase.dart';

class LoadFavoriteMoviesUsecase extends ILoadFavoriteMoviesUsecase {
  final ILoadFavoriteMoviesRepository _repository;

  LoadFavoriteMoviesUsecase(this._repository);

  @override
  Future<IResponseResult<List<Movie>>> getList() async{
    try{
      return Success(await _repository.getList());
    }catch(e){
      return Fail(AppException(id: e, method: getList, namespace: this));
    }
  }
}