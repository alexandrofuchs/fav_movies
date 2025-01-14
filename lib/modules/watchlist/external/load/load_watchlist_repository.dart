import 'package:fav_movies/core/common/models/movie.dart';
import 'package:fav_movies/modules/watchlist/domain/i_repositories/i_load_watchlist_repository.dart';
import 'package:sqflite/sqflite.dart';

part 'load_watchlist_model.dart';

class LoadWatchListRepository implements ILoadWatchListRepository{
  final Database _database;

  LoadWatchListRepository(this._database);
  
  @override
  Future<List<Movie>> getList() async {
    final response = await _database.query('MovieWatchList');
    return LoadWatchListModel.fromMapList(response);
  }

}