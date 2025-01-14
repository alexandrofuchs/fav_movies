import 'package:equatable/equatable.dart';

part 'movie_genre.dart';

class MovieDetails extends Equatable {
  const MovieDetails({
    required this.id,
    required this.genre,
    required this.status,
  });

  final int id;
  final List<MovieGenre> genre;
  final String status;

  @override
  List<Object?> get props => [id];
}