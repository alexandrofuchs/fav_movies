import 'package:fav_movies/core/common/models/enums/movie_language.dart';
import 'package:fav_movies/core/common/models/movie.dart';
import 'package:fav_movies/modules/favorites/domain/i_repositories/i_load_favorite_movies_repository.dart';
import 'package:sqflite/sqflite.dart';

part 'load_favorite_movies_model.dart';

class LoadFavoriteMoviesRepository implements ILoadFavoriteMoviesRepository{
  final Database _database;

  LoadFavoriteMoviesRepository(this._database);
  
  @override
  Future<List<Movie>> getList() async {
    final response = await _database.query('FavoriteMovies');
    return LoadFavoriteMovieModel.fromMapList(response);
  }

}