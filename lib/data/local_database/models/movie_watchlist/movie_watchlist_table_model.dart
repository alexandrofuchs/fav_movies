import 'package:fav_movies/data/local_database/models/common/movie_table_model.dart';

abstract class MovieWatchListTableModel {
  static String get createTableCommand =>
      'CREATE TABLE IF NOT EXISTS MovieWatchList (${MovieTableModel.tableFields.join(', ')})';
}
