import 'package:fav_movies/core/common/exceptions/app_exception.dart';
import 'package:fav_movies/core/common/models/movie.dart';
import 'package:fav_movies/core/common/responses/results/i_response/i_response_result.dart';
import 'package:fav_movies/modules/search/domain/i_repositories/i_search_movie_repository.dart';
import 'package:fav_movies/modules/search/domain/i_usecases/i_search_movie_usecase.dart';

class SearchMovieUsecase implements ISearchMovieUsecase{
  final ISearchMovieRepository _repository;

  SearchMovieUsecase(this._repository);
  
  @override
  Future<IResponseResult<List<Movie>>> searchMovieByText(String text) async {
    try{
      return Success(await _repository.searchMovieByText(text));
    }catch(e){
      return Fail(AppException(id: e, method: searchMovieByText, namespace: this));
    }
  }
  
}