part of 'favorite_movie_repository.dart';

extension FavoriteMovieModel on Movie {
  Map<String, dynamic> toTableMap() => {
        'id': id,
        'adult': adult ? 1 : 0,
        'genre_ids': genreIds.join(','),
        'original_language': originalLanguage,
        'original_title': originalTitle,
        'overview': overview,
        'popularity': popularity,
        'poster_path': posterPath,
        'release_date': releaseDate,
        'title': title,
        'video': video ? 1 : 0,
        'vote_average': voteAverage,
        'vote_count': voteCount,
        'saved_in_favorites': 1,
      };
}
