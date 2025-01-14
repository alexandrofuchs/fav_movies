import 'package:fav_movies/data/local_database/models/common/movie_table_model.dart';

abstract class FavoriteMoviesTableModel {
  static String get createTableCommand =>
      'CREATE TABLE IF NOT EXISTS FavoriteMovies (${MovieTableModel.tableFields.join(', ')})';
}
