import 'package:fav_movies/core/common/exceptions/app_exception.dart';
import 'package:fav_movies/core/common/models/movie.dart';
import 'package:fav_movies/core/common/responses/results/i_response/i_response_result.dart';
import 'package:fav_movies/core/common/responses/status/response_status.dart';
import 'package:fav_movies/modules/details/domain/i_repositories/i_manage_watchlist_repository.dart';
import 'package:fav_movies/modules/details/domain/i_usecases/i_manage_watchlist_usecase.dart';

class ManageWatchListUsecase implements IManageWatchListUsecase {
  final IManageWatchListRepository _repository;

  ManageWatchListUsecase(this._repository);
  
  @override
  Future<IResponseResult<ResponseStatus>> addMovieToWatchList(Movie movie) async {
    try{
      return Success(await _repository.addToWatchList(movie));
    }catch(e){
      return Fail(AppException(id: e, method: addMovieToWatchList, namespace: this));
    }
  }

  @override
  Future<IResponseResult<ResponseStatus>> removeMovieFromWatchList(int movieId) async {
    try{
      return Success(await _repository.removeFromWatchList(movieId));
    }catch(e){
      return Fail(AppException(id: e, method: removeMovieFromWatchList, namespace: this));
    }
  }
  
  @override
  Future<IResponseResult<Movie>> verifyMovieInWatchList(int movieId) async {
    try{
      return Success(await _repository.verifyMovieInWatchList(movieId));
    }catch(e){
      return Fail(AppException(id: e, method: verifyMovieInWatchList, namespace: this));
    }
  }

}