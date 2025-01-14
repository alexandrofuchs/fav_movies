import 'package:fav_movies/core/external/api/domain/i_interceptor/i_request_interceptor.dart';
import 'package:fav_movies/modules/details/domain/i_repositories/i_movie_details_repository.dart';
import 'package:fav_movies/modules/details/domain/models/movie_details.dart';

part 'movie_details_model.dart';

class MovieDetailsRepository implements IMovieDetailsRepository{
  final IRequestInterceptor _requestInterceptor;

  MovieDetailsRepository(this._requestInterceptor);

  @override
  Future<MovieDetails> getDetails(int id) async {
    final response = await _requestInterceptor.get('/movie/$id');
    return MovieDetailsModel.fromMap(response);
  }
} 