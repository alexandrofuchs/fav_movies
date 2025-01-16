import 'package:equatable/equatable.dart';
import 'package:fav_movies/core/common/exceptions/app_exception.dart';
import 'package:fav_movies/core/common/models/movie.dart';
import 'package:fav_movies/modules/search/domain/i_usecases/i_search_movie_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchEvent extends Equatable {
  final String text;

  const SearchEvent(this.text);
  @override
  List<Object?> get props => [text];
}

enum SearchMovieBlocStatus {
  initial,
  loading,
  loaded,
  failed,
}

class SearchMovieBlocState extends Equatable {
  final List<Movie> sourceList;
  final List<Movie> filteredList;
  final AppException? error;

  final SearchMovieBlocStatus status;

  final String? filterText;

  const SearchMovieBlocState(this.status,
      {this.sourceList = const [],
      this.filteredList = const [],
      this.error,
      this.filterText});

  @override
  List<Object?> get props => [
        status,
        sourceList,
        filteredList,
        filterText,
      ];
}

class SearchMovieBloc extends Bloc<SearchEvent, SearchMovieBlocState> {
  final ISearchMovieUsecase _usecase;

  SearchMovieBloc(this._usecase)
      : super(const SearchMovieBlocState(SearchMovieBlocStatus.initial)) {
    on<SearchEvent>((event, emit) async {

      emit(const SearchMovieBlocState(SearchMovieBlocStatus.loading));

      final response = await _usecase.searchMovieByText(event.text);

      response.resolve(
          onFail: (err) =>
              emit(const SearchMovieBlocState(SearchMovieBlocStatus.failed)),
          onSuccess: (data) => emit(SearchMovieBlocState(
              SearchMovieBlocStatus.loaded,
              sourceList: data,
              filteredList: data)));
    });
  }
}
