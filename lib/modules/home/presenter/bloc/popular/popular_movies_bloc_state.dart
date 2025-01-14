part of 'popular_movies_bloc.dart';

enum PopularMoviesBlocStatus {
  firstLoading,
  loadingMore,
  failed,
  loaded,
}

class PopularMoviesBlocState extends Equatable {
  final PopularMoviesBlocStatus status;
  final PopularMovies? popularMovies;

  const PopularMoviesBlocState(this.status, {this.popularMovies});

  @override
  List<Object?> get props => [status, popularMovies?.page];
}
