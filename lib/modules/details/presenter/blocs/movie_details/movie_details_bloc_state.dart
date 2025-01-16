part of 'movie_details_bloc.dart';

enum MovieDetailsBlocStatus {
  loading,
  failed,
  loaded,
}

class MovieDetailsBlocState extends Equatable {
  final MovieDetailsBlocStatus status;
  final MovieDetails? movieDetails;

  const MovieDetailsBlocState(this.status, {this.movieDetails});

  @override
  List<Object?> get props => [status];
}
