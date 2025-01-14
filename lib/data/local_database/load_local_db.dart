import 'package:fav_movies/data/local_database/models/favorite_movies/favorite_movies_table_model.dart';
import 'package:fav_movies/data/local_database/models/movie_reviews/movie_reviews_table_model.dart';
import 'package:fav_movies/data/local_database/models/movie_watchlist/movie_watchlist_table_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

late Database localDatabase;

Future<void> loadLocalDb() async {
  try {
    localDatabase = await openDatabase('fav_movies.db', version: 1,
        onOpen: (Database db) async {
      debugPrint(FavoriteMoviesTableModel.createTableCommand);
      await db.execute(FavoriteMoviesTableModel.createTableCommand);

      debugPrint(MovieReviewsTableModel.createTableCommand);
      await db.execute(MovieReviewsTableModel.createTableCommand);

      debugPrint(MovieWatchListTableModel.createTableCommand);
      await db.execute(MovieWatchListTableModel.createTableCommand);
    });
  } catch (e) {
    debugPrint(e.toString());
  }
}
