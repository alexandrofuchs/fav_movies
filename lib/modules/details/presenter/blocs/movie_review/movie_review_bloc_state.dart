part of 'movie_review_bloc.dart';

enum MovieReviewBlocStatus {
  initial,
  loading,
  failed,
  loaded,
}

class MovieReviewBlocState extends Equatable {
  final MovieReviewBlocStatus status;
  final MovieReview? movieReview;

  const MovieReviewBlocState(this.status, {this.movieReview});

  @override
  List<Object?> get props => [status];
}

