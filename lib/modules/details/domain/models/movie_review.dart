import 'package:equatable/equatable.dart';

class MovieReview extends Equatable {
  final int movieId;
  final int rate;
  final String description;

  const MovieReview(
      {required this.movieId, required this.rate, required this.description});

  @override
  List<Object?> get props => [movieId];
}
