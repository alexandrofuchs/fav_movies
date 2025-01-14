import 'package:equatable/equatable.dart';
import 'package:fav_movies/modules/details/domain/i_usecases/i_review_movie_repository.dart';
import 'package:fav_movies/modules/details/domain/models/movie_review.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SaveReviewEvent extends Equatable {
  final MovieReview review;

  const SaveReviewEvent(this.review);

  @override
  List<Object?> get props => [review];
}

enum ReviewMovieBlocStatus {
  initial,
  saving,
  failed,
  saved,
}

class ReviewMovieBloc extends Bloc<SaveReviewEvent, ReviewMovieBlocStatus> {
  final IReviewMovieUsecase _usecase;

  ReviewMovieBloc(this._usecase) : super(ReviewMovieBlocStatus.initial) {
    on<SaveReviewEvent>(
      (event, emit) async {

        emit(ReviewMovieBlocStatus.saving);

        final response = await _usecase.saveReview(event.review);

        response.resolve(
            onFail: (err) => emit(ReviewMovieBlocStatus.failed),
            onSuccess: (data) => emit(ReviewMovieBlocStatus.saved));
      },
    );
  }
}
