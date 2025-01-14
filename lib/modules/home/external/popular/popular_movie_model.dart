part of 'popular_movies_repository.dart';

extension PopularMovieModel on PopularMovie {
  static PopularMovie fromMap(Map<String, dynamic> map) => PopularMovie(
        adult: map['adult'],
        genreIds: List<int>.from(map['genre_ids']),
        id: map['id'],
        originalLanguage: map['original_language'],
        originalTitle: map['original_title'],
        overview: map['overview'],
        popularity: map['popularity'],
        posterPath: map['poster_path'],
        releaseDate: map['release_date'],
        title: map['title'],
        video: map['video'],
        voteAverage: map['vote_average'],
        voteCount: map['vote_count'],
      );

  static List<PopularMovie> fromMapList(List<dynamic> list) =>
      list.map((e) => PopularMovieModel.fromMap(e)).toList();
}

extension PopularMoviesModel on PopularMovies {
  static PopularMovies fromMap(Map<String, dynamic> map) =>
      PopularMovies(PopularMovieModel.fromMapList(map['results']), map['page']);
}