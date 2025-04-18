import 'package:equatable/equatable.dart';
import 'package:fav_movies/core/common/models/movie.dart';
import 'package:fav_movies/modules/home/domain/i_usecase/i_popular_movies_usecase.dart';
import 'package:fav_movies/modules/home/domain/models/popular_movies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'popular_movies_bloc_event.dart';
part 'popular_movies_bloc_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesBlocEvent, PopularMoviesBlocState> {
  final IPopularMoviesUsecase _usecase;

  PopularMoviesBloc(this._usecase) : super(const PopularMoviesBlocState(PopularMoviesBlocStatus.firstLoading)) {
    on<GetMoviesEvent>(
      (event, emit) async {

        emit(const PopularMoviesBlocState(PopularMoviesBlocStatus.firstLoading));

        final response = await _usecase.getMovies(1);

        response.resolve(
            onFail: (err) => emit(const PopularMoviesBlocState(PopularMoviesBlocStatus.failed)),
            onSuccess: (data) => emit(PopularMoviesBlocState(PopularMoviesBlocStatus.loaded, popularMovies: data, filteredList: data.list)));
      },
    );


     on<SearchByTextEvent>(
      (event, emit) {
        var state = this.state.copyWith(PopularMoviesBlocStatus.loaded, filterText: event.filterText);
        emit(state.copyWith(PopularMoviesBlocStatus.loaded,
            filteredList: _filterByText(state)));
      },
    );
  }


  List<Movie> _filterByText(
      PopularMoviesBlocState state) {
    if (state.filterText != null && state.filterText!.isNotEmpty) {
      return state.popularMovies!.list
          .where((element) =>
              element.title.toUpperCase().contains(state.filterText!.toUpperCase()) ||
              element.originalTitle.toUpperCase().contains(state.filterText!.toUpperCase()))
          .toList();
    }

    return state.popularMovies!.list;
  }
}
