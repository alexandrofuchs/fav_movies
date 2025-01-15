import 'package:fav_movies/core/common/models/enums/movie_language.dart';
import 'package:fav_movies/core/common/models/movie.dart';
import 'package:fav_movies/core/external/api/domain/i_interceptor/i_request_interceptor.dart';
import 'package:fav_movies/modules/search/domain/i_repositories/i_search_movie_repository.dart';

part 'search_movie_model.dart';

class SearchMovieRepository implements ISearchMovieRepository {
  final IRequestInterceptor _request;

  SearchMovieRepository(this._request);
  
  @override
  Future<List<Movie>> searchMovieByText(String text) async {
    final response = await _request.get('/search/movie?query=$text');
    return SearchMovieModel.fromMapList(response['results']);
  }

}