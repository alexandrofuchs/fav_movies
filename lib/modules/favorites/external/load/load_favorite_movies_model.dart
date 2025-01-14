part of 'load_favorite_movies_repository.dart';

extension LoadFavoriteMovieModel on Movie {
  static Movie fromMap(Map<String, dynamic> map) => Movie(
        adult: map['adult'] == 1,
        genreIds: List<int>.from((map['genre_ids'] as String).split(',').map((e) => int.parse(e))),
        id: map['id'],
        originalLanguage: map['original_language'],
        originalTitle: map['original_title'],
        overview: map['overview'],
        popularity: map['popularity'],
        posterPath: map['poster_path'],
        releaseDate: map['release_date'],
        title: map['title'],
        video: map['video'] == 1,
        voteAverage: map['vote_average'],
        voteCount: map['vote_count'],
        savedInFavorites: map['saved_in_favorites'] == 1,
        savedInWatchlist: map['saved_in_watchlist'] == 1,
      );

  static List<Movie> fromMapList(List<dynamic> list) =>
      list.map((e) => LoadFavoriteMovieModel.fromMap(e)).toList();
}
