import 'package:fav_movies/core/common/exceptions/app_exception.dart';
import 'package:fav_movies/core/common/models/movie.dart';
import 'package:fav_movies/core/common/responses/results/i_response/i_response_result.dart';
import 'package:fav_movies/modules/watchlist/domain/i_repositories/i_load_watchlist_repository.dart';
import 'package:fav_movies/modules/watchlist/domain/i_usecases/i_load_watchlist_usecase.dart';

class LoadWatchListUsecase extends ILoadWatchListUsecase {
  final ILoadWatchListRepository _repository;

  LoadWatchListUsecase(this._repository);

  @override
  Future<IResponseResult<List<Movie>>> getList() async{
    try{
      return Success(await _repository.getList());
    }catch(e){
      return Fail(AppException(id: e, method: getList, namespace: this));
    }
  }
}