part of 'movie_details.dart';

class MovieGenre extends Equatable {
  const MovieGenre(this.id, this.name);

  final int id;
  final String name;

  @override
  List<Object?> get props => [id, name];

  @override
  String toString() {
    return name;
  }
}
