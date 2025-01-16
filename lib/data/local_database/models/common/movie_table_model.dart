abstract class MovieTableModel {
  static final tableFields = {
    'id INTEGER PRIMARY KEY',
    'adult INTEGER',
    'genre_ids TEXT',
    'original_language TEXT',
    'original_title TEXT',
    'overview TEXT',
    'popularity REAL',
    'poster_path TEXT',
    'release_date TEXT',
    'title TEXT',
    'video INTEGER',
    'vote_average REAL',
    'vote_count INTEGER',
    'saved_in_favorites INTEGER',
    'saved_in_watchlist INTEGER',
  };
}