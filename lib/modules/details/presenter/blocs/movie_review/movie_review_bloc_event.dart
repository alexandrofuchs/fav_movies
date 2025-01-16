part of 'movie_review_bloc.dart';

abstract class IMovieReviewEvent extends Equatable {}

class SaveReviewEvent extends IMovieReviewEvent {
  final MovieReview review;

  SaveReviewEvent(this.review);

  @override
  List<Object?> get props => [review];
}

class GetReviewEvent extends IMovieReviewEvent {
  final int movieId;

  GetReviewEvent(this.movieId);

  @override
  List<Object?> get props => [movieId];
}
