import 'package:equatable/equatable.dart';
import 'package:fav_movies/core/common/models/movie.dart';
import 'package:fav_movies/modules/details/domain/i_usecases/i_manage_watchlist_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class IManageWatchlistBlocEvent extends Equatable {}

class AddToWatchlistEvent extends IManageWatchlistBlocEvent {
  final Movie movie;

  AddToWatchlistEvent(this.movie);

  @override
  List<Object?> get props => [movie];
}

class RemoveFromWatchlistEvent extends IManageWatchlistBlocEvent {
  final int movieId;

  RemoveFromWatchlistEvent(this.movieId);

  @override
  List<Object?> get props => [movieId];
}

class VerifyWatchlistEvent extends IManageWatchlistBlocEvent {
  final int movieId;

  VerifyWatchlistEvent(this.movieId);

  @override
  List<Object?> get props => [movieId];
}

enum ManageWatchlistBlocStatus {
  initial,
  loading,
  inWatchList,
  notInWatchlist,
}

class ManageWatchlistBloc
    extends Bloc<IManageWatchlistBlocEvent, ManageWatchlistBlocStatus> {
  final IManageWatchListUsecase _usecase;

  ManageWatchlistBloc(this._usecase)
      : super(ManageWatchlistBlocStatus.initial) {
    on<AddToWatchlistEvent>(
      (event, emit) async {
        emit(ManageWatchlistBlocStatus.loading);

        final response = await _usecase.addMovieToWatchList(event.movie);

        response.resolve(
            onFail: (err) => emit(ManageWatchlistBlocStatus.notInWatchlist),
            onSuccess: (data) => emit(ManageWatchlistBlocStatus.inWatchList));
      },
    );

    on<RemoveFromWatchlistEvent>((event, emit) async {
      emit(ManageWatchlistBlocStatus.loading);

      final response = await _usecase.removeMovieFromWatchList(event.movieId);

      response.resolve(
          onFail: (err) => emit(ManageWatchlistBlocStatus.inWatchList),
          onSuccess: (data) => emit(ManageWatchlistBlocStatus.notInWatchlist));
    });

    on<VerifyWatchlistEvent>((event, emit) async {
      emit(ManageWatchlistBlocStatus.loading);

      final response = await _usecase.verifyMovieInWatchList(event.movieId);

      response.resolve(
          onFail: (err) => emit(ManageWatchlistBlocStatus.notInWatchlist),
          onSuccess: (data) => emit(ManageWatchlistBlocStatus.inWatchList));
    });
  }
}
