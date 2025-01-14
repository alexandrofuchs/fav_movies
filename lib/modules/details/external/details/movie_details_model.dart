part of 'movie_details_repository.dart';

extension MovieDetailsModel on MovieDetails {
  static fromMap(Map<String, dynamic> map) => MovieDetails(
      id: map['id'],
      genre: MovieGenreModel.fromMapList(map['genres']),
      status: map['status']);
}

extension MovieGenreModel on MovieGenre {
  static MovieGenre fromMap(Map<String, dynamic> map) =>
      MovieGenre(map['id'], map['name']);

  static List<MovieGenre> fromMapList(List<dynamic> list) =>
      list.map((e) => MovieGenreModel.fromMap(e)).toList();
}
