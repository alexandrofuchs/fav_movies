part of 'popular_movies_repository.dart';

extension PopularMovieModel on Movie {
  static const _imageAPIBaseURL = 'https://image.tmdb.org/t/p/original/';

  static Movie fromMap(Map<String, dynamic> map) => Movie(
        adult: map['adult'],
        genreIds: List<int>.from(map['genre_ids']),
        id: map['id'],
        originalLanguage: MovieLanguage.fromValue(map['original_language']),
        originalTitle: map['original_title'],
        overview: map['overview'],
        popularity: map['popularity'],
        posterPath: _imageAPIBaseURL + map['poster_path'],
        releaseDate: map['release_date'],
        title: map['title'],
        video: map['video'],
        voteAverage: map['vote_average'],
        voteCount: map['vote_count'],
        savedInFavorites: false,
        savedInWatchlist: false,
      );

  static List<Movie> fromMapList(List<dynamic> list) =>
      list.map((e) => PopularMovieModel.fromMap(e)).toList();
}

extension PopularMoviesModel on PopularMovies {
  static PopularMovies fromMap(Map<String, dynamic> map) =>
      PopularMovies(PopularMovieModel.fromMapList(map['results']), map['page']);
}