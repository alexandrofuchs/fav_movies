import 'package:equatable/equatable.dart';
import 'package:fav_movies/core/common/models/enums/movie_language.dart';

class Movie extends Equatable {
  final int id;
  final MovieLanguage originalLanguage;
  final String originalTitle;
  final String overview;
  final num popularity;
  final String? posterPath;
  final String releaseDate;
  final String title;
  final bool video;
  final num voteAverage;
  final int voteCount;

  final bool adult;
  final bool savedInFavorites;
  final bool savedInWatchlist;

  final List<int> genreIds;

  const Movie(
      {required this.id,
      required this.originalLanguage,
      required this.originalTitle,
      required this.overview,
      required this.popularity,
      required this.posterPath,
      required this.releaseDate,
      required this.title,
      required this.video,
      required this.voteAverage,
      required this.voteCount,
      required this.adult,
      required this.genreIds,
      required this.savedInFavorites,
      required this.savedInWatchlist,
      });

  @override
  List<Object?> get props => [id];
}