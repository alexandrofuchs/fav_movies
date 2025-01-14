abstract class MovieReviewsTableModel {
  static final _tableFields = {
    'movie_id INTEGER PRIMARY KEY',
    'rating INTEGER',
    'description TEXT',
  };

  static String get createTableCommand =>
      'CREATE TABLE IF NOT EXISTS MovieReviews (${_tableFields.join(', ')})';
}
