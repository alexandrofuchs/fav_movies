import 'package:fav_movies/data/local_database/models/favorite_movies/favorite_movies.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

late Database localDatabase;

Future<void> loadLocalDb() async {
  try {
    localDatabase = await openDatabase('fav_movies.db', version: 1,
        onOpen: (Database db) async {
      debugPrint(FavoriteMoviesTableModel.createTableCommand);
      await db.execute(FavoriteMoviesTableModel.createTableCommand);
    });
  } catch (e) {
    debugPrint(e.toString());
  }
}
