import 'package:equatable/equatable.dart';
import 'package:fav_movies/core/common/models/movie.dart';
import 'package:fav_movies/modules/watchlist/domain/i_usecases/i_load_watchlist_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'load_watchlist_event.dart';
part 'load_watchlist_bloc_state.dart';

class LoadWatchListBloc
    extends Bloc<LoadMoviesEvent, LoadWatchListBlocState> {
  final ILoadWatchListUsecase _usecase;

  LoadWatchListBloc(this._usecase)
      : super(const LoadWatchListBlocState(LoadWatchListBlocStatus.loading)) {
    on<LoadMoviesEvent>((event, emit) async {
      emit(const LoadWatchListBlocState(LoadWatchListBlocStatus.loading));

      final response = await _usecase.getList();

      response.resolve(
          onFail: (err) =>
              emit(const LoadWatchListBlocState(LoadWatchListBlocStatus.failed)),
          onSuccess: (data) => emit(LoadWatchListBlocState(
              LoadWatchListBlocStatus.loaded,
              sourceList: data)));
    });
  }
}
