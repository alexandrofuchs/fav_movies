part of 'search_movie_repository.dart';

extension SearchMovieModel on Movie {
  static const _imageAPIBaseURL = 'https://image.tmdb.org/t/p/w300/';

  static Movie fromMap(Map<String, dynamic> map) => Movie(
        adult: map['adult'],
        genreIds: List<int>.from(map['genre_ids']),
        id: map['id'],
        originalLanguage: MovieLanguage.fromValue(map['original_language']),
        originalTitle: map['original_title'],
        overview: map['overview'],
        popularity: map['popularity'],
        posterPath: map['poster_path'] != null ? _imageAPIBaseURL + map['poster_path'] : null,
        releaseDate: map['release_date'],
        title: map['title'],
        video: map['video'],
        voteAverage: map['vote_average'],
        voteCount: map['vote_count'],
        savedInFavorites: false,
        savedInWatchlist: false,
      );

  static List<Movie> fromMapList(List<dynamic> list) =>
      list.map((e) => SearchMovieModel.fromMap(e)).toList();
}
