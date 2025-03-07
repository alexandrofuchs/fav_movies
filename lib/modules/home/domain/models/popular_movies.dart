import 'package:equatable/equatable.dart';
import 'package:fav_movies/core/common/models/movie.dart';

class PopularMovies extends Equatable {
  final List<Movie> list;
  final int page;

  const PopularMovies(this.list, this.page);

  @override
  List<Object?> get props => [page, list];
}