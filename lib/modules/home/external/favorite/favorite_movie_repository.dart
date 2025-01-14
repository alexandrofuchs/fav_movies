import 'package:fav_movies/core/common/responses/status/response_status.dart';
import 'package:fav_movies/modules/home/domain/i_repository/i_favorite_movie_repository.dart';
import 'package:fav_movies/modules/home/domain/models/movie.dart';
import 'package:sqflite/sqflite.dart';

part 'favorite_movie_model.dart';

class FavoriteMoviesRepository implements IFavoriteMoviesRepository {
  final Database _database;

  FavoriteMoviesRepository(this._database);
  
  @override
  Future<ResponseStatus> save(Movie movie) async {
    final res = await _database.insert('FavoriteMovies', movie.toTableMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    return ResponseStatus(code: res, message: 'res');
  }
}