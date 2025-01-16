part of 'favorite_movie_bloc.dart';

class SaveMovieEvent extends Equatable {
  final Movie movie;

  const SaveMovieEvent(this.movie);

  @override
  List<Object?> get props => [movie];
}
