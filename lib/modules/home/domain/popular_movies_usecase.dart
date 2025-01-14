import 'package:fav_movies/core/common/exceptions/app_exception.dart';
import 'package:fav_movies/core/common/responses/results/i_response/i_response_result.dart';
import 'package:fav_movies/modules/home/domain/i_repository/i_popular_movies_repository.dart';
import 'package:fav_movies/modules/home/domain/i_usecase/i_popular_movies_usecase.dart';
import 'package:fav_movies/modules/home/domain/models/popular_movies.dart';

class PopularMoviesUsecase implements IPopularMoviesUsecase {
  final IPopularMoviesRepository _repository;

  PopularMoviesUsecase(this._repository);

  @override
  Future<IResponseResult<PopularMovies>> getMovies(int page) async{
    try{
      return Success(await _repository.getMovies(page));
    }catch(e){
      return Fail(AppException(id: e, method: getMovies, namespace: this));
    }
  }

}