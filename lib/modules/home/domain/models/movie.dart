import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final num popularity;
  final String posterPath;
  final String releaseDate;
  final String title;
  final bool video;
  final num voteAverage;
  final int voteCount;

  final bool adult;
  final bool savedInFavorites;

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
      required this.savedInFavorites
      });

  @override
  List<Object?> get props => [id];
}