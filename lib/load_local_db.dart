import 'package:sqflite/sqflite.dart';

late Database localDatabase;

Future<void> loadLocalDb() async {
   await openDatabase('fav_movies.db', version: 1,
      onCreate: (Database db, int version) async {
    await db.execute('CREATE TABLE FavoriteMovies (id INTEGER PRIMARY KEY)');
  });
}
