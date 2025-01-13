part of 'popular_movies_repository.dart';

extension PopularMovieModel on PopularMovie{
  static PopularMovie fromMap(Map<String, dynamic> map) => PopularMovie();

  static List<PopularMovie> fromMapList(List<dynamic> list) => list.map(
    (e) => PopularMovieModel.fromMap(e)).toList();
}

extension PopularMoviesModel on PopularMovies{
  static PopularMovies fromMap(Map<String, dynamic> map) => 
    PopularMovies(PopularMovieModel.fromMapList(map['results']), map['page']);
}