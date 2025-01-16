part of 'popular_movies_bloc.dart';

abstract class PopularMoviesBlocEvent extends Equatable {
  const PopularMoviesBlocEvent();
}

class GetMoviesEvent extends PopularMoviesBlocEvent {
  final int page;

  const GetMoviesEvent(this.page);

  @override
  List<Object?> get props => [page];
}

class SearchByTextEvent extends PopularMoviesBlocEvent {
  final String filterText;

  const SearchByTextEvent(this.filterText);

  @override
  List<Object?> get props => [filterText];
}