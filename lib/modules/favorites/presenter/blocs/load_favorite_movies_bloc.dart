import 'package:equatable/equatable.dart';
import 'package:fav_movies/core/common/models/models/movie.dart';
import 'package:fav_movies/modules/favorites/domain/i_usecases/i_load_favorite_movies_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'load_favorite_movies_event.dart';
part 'load_favorite_movies_bloc_state.dart';

class LoadFavoriteMoviesBloc
    extends Bloc<LoadMoviesEvent, LoadFavoriteBlocState> {
  final ILoadFavoriteMoviesUsecase _usecase;

  LoadFavoriteMoviesBloc(this._usecase)
      : super(const LoadFavoriteBlocState(LoadFavoriteBlocStatus.loading)) {
    on<LoadMoviesEvent>((event, emit) async {
      emit(const LoadFavoriteBlocState(LoadFavoriteBlocStatus.loading));

      final response = await _usecase.getList();

      response.resolve(
          onFail: (err) =>
              emit(const LoadFavoriteBlocState(LoadFavoriteBlocStatus.failed)),
          onSuccess: (data) => emit(LoadFavoriteBlocState(
              LoadFavoriteBlocStatus.loaded,
              sourceList: data)));
    });
  }
}
