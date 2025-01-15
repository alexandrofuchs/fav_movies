part of 'movie_details_repository.dart';

extension MovieDetailsModel on MovieDetails {
  static fromMap(Map<String, dynamic> map) => MovieDetails(
      id: map['id'],
      genre: MovieGenreModel.fromMapList(map['genres']),
      status: map['status'],
      trailer: MovieTrailerModel.fromMapList(map['videos']['results']));
}

extension MovieTrailerModel on MovieTrailer{
  static MovieTrailer fromMap(Map<String, dynamic> map) =>
    MovieTrailer(map['key']);

  static List<MovieTrailer> fromMapList(List<dynamic> list) =>
    list.map((e) => MovieTrailerModel.fromMap(e)).toList();
}

extension MovieGenreModel on MovieGenre {
  static MovieGenre fromMap(Map<String, dynamic> map) =>
      MovieGenre(map['id'], map['name']);

  static List<MovieGenre> fromMapList(List<dynamic> list) =>
      list.map((e) => MovieGenreModel.fromMap(e)).toList();
}
