import 'package:equatable/equatable.dart';
import 'package:fav_movies/modules/home/domain/i_usecase/i_popular_movies_usecase.dart';
import 'package:fav_movies/modules/home/domain/models/popular_movies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'popular_movies_bloc_event.dart';
part 'popular_movies_bloc_state.dart';

class PopularMoviesBloc extends Bloc<GetMoviesEvent, PopularMoviesBlocState> {
  final IPopularMoviesUsecase _usecase;

  PopularMoviesBloc(this._usecase) : super(const PopularMoviesBlocState(PopularMoviesBlocStatus.firstLoading)) {
    on<GetMoviesEvent>(
      (event, emit) async {

        final response = await _usecase.getMovies(1);

        response.resolve(
            onFail: (err) => emit(const PopularMoviesBlocState(PopularMoviesBlocStatus.failed)),
            onSuccess: (data) => emit(PopularMoviesBlocState(PopularMoviesBlocStatus.loaded, popularMovies: data)));
      },
    );
  }
}
