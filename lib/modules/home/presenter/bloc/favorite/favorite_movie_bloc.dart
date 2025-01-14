import 'package:equatable/equatable.dart';
import 'package:fav_movies/modules/home/domain/i_usecase/i_favorite_movie_usecase.dart';
import 'package:fav_movies/modules/home/domain/models/movie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorite_movie_bloc_event.dart';
part 'favorite_movie_bloc_state.dart';

class FavoriteMovieBloc extends Bloc<SaveMovieEvent, FavoriteMovieBlocStatus> {
  final IFavoriteMoviesUsecase _usecase;

  FavoriteMovieBloc(this._usecase) : super(FavoriteMovieBlocStatus.initial) {
    on<SaveMovieEvent>((event, emit) async {
      emit(FavoriteMovieBlocStatus.saving);

      final response = await _usecase.save(event.movie);

      response.resolve(
        onFail: (err) => emit(FavoriteMovieBlocStatus.failed),
        onSuccess: (data) => emit(FavoriteMovieBlocStatus.saved),
      );
    });
  }
}
