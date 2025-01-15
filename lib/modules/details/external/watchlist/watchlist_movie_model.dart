part of 'manage_watchlist_repository.dart';


extension WatchlistMovieModel on Movie {
  Map<String, dynamic> toTableMap() => {
        'id': id,
        'adult': adult ? 1 : 0,
        'genre_ids': genreIds.join(','),
        'original_language': originalLanguage.value,
        'original_title': originalTitle,
        'overview': overview,
        'popularity': popularity,
        'poster_path': posterPath,
        'release_date': releaseDate,
        'title': title,
        'video': video ? 1 : 0,
        'vote_average': voteAverage,
        'vote_count': voteCount,
        'saved_in_favorites': savedInFavorites ? 1 : 0,
        'saved_in_watchlist': 1,
      };

    static Movie fromTableMap(Map<String, dynamic> map) => Movie(
        adult: map['adult'] == 1,
        genreIds: List<int>.from((map['genre_ids'] as String).split(',').map((e) => int.parse(e))),
        id: map['id'],
        originalLanguage: MovieLanguage.fromValue(map['original_language']),
        originalTitle: map['original_title'],
        overview: map['overview'],
        popularity: map['popularity'],
        posterPath: map['poster_path'],
        releaseDate: map['release_date'],
        title: map['title'],
        video: map['video'] == 1,
        voteAverage: map['vote_average'],
        voteCount: map['vote_count'],
        savedInFavorites: map['saved_in_favorites'] == 1,
        savedInWatchlist: map['saved_in_watchlist'] == 1,
    );
}
