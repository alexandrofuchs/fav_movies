part of 'load_watchlist_bloc.dart';

enum LoadWatchListBlocStatus {
  loading,
  failed,
  loaded,
}

class LoadWatchListBlocState extends Equatable {
  final LoadWatchListBlocStatus status;
  final List<Movie>? sourceList;

  const LoadWatchListBlocState(this.status, {this.sourceList});

  @override
  List<Object?> get props => [status];
}
