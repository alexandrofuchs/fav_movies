import 'package:fav_movies/core/common/models/enums/movie_language.dart';
import 'package:fav_movies/core/common/models/movie.dart';
import 'package:fav_movies/core/common/responses/status/response_status.dart';
import 'package:fav_movies/modules/details/domain/i_repositories/i_manage_watchlist_repository.dart';
import 'package:sqflite/sqflite.dart';

part 'watchlist_movie_model.dart';

class ManageWatchListRepository implements IManageWatchListRepository {
  final Database _database;

  ManageWatchListRepository(this._database);
  
  @override
  Future<ResponseStatus> addToWatchList(Movie movie) async {
    final response = await _database.insert('MovieWatchlist', movie.toTableMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    return ResponseStatus(code: response, message: 'ok');
  }

  @override
  Future<ResponseStatus> removeFromWatchList(int movieId) async {
    final response = await _database.delete('MovieWatchlist', where: 'id = ?', whereArgs: [movieId]);
    return ResponseStatus(code: response, message: 'ok');
  }
  
  @override
  Future<Movie> verifyMovieInWatchList(int movieId) async {
    final response = await _database.query('MovieWatchlist', where: 'id = ?', whereArgs: [movieId]);
    return WatchlistMovieModel.fromTableMap(response.first);
  }

}