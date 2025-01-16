part of 'load_favorite_movies_bloc.dart';

enum LoadFavoriteBlocStatus {
  loading,
  failed,
  loaded,
}

class LoadFavoriteBlocState extends Equatable {
  final LoadFavoriteBlocStatus status;
  final List<Movie>? sourceList;

  const LoadFavoriteBlocState(this.status, {this.sourceList});

  @override
  List<Object?> get props => [status];
}
