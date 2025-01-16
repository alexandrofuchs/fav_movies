part of 'movie_details_bloc.dart';

class GetMovieDetailsEvent extends Equatable {
  final int movieId;

  const GetMovieDetailsEvent(this.movieId);

  @override
  List<Object?> get props => [movieId];
}