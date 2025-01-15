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
  final List<Movie> filteredList;

  final String? filterText;

  const PopularMoviesBlocState(this.status,
      {this.popularMovies, this.filteredList = const [], this.filterText});

  @override
  List<Object?> get props =>
      [status, popularMovies?.page, filteredList, filterText];

  PopularMoviesBlocState copyWith(
    PopularMoviesBlocStatus status, {
    String? filterText,
    List<Movie>? filteredList,
  }) {
    return PopularMoviesBlocState(
      status,
      filterText: filterText ?? this.filterText,
      popularMovies: popularMovies,
      filteredList: filteredList ?? this.filteredList,
    );
  }
}
