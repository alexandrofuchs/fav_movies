import 'package:equatable/equatable.dart';

part 'movie_genre.dart';
part 'movie_trailer.dart';

class MovieDetails extends Equatable {
  const MovieDetails({
    required this.id,
    required this.genre,
    required this.trailer,
    required this.status,
  });

  final int id;
  final List<MovieGenre> genre;
  final List<MovieTrailer> trailer;
  final String status;

  @override
  List<Object?> get props => [id];
}