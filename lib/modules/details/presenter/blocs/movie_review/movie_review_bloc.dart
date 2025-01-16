import 'package:equatable/equatable.dart';
import 'package:fav_movies/modules/details/domain/i_usecases/i_movie_review_usecase.dart';
import 'package:fav_movies/modules/details/domain/models/movie_review.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_review_bloc_event.dart';
part 'movie_review_bloc_state.dart';

class MovieReviewBloc extends Bloc<IMovieReviewEvent, MovieReviewBlocState> {
  final IMovieReviewUsecase _usecase;

  MovieReviewBloc(this._usecase)
      : super(const MovieReviewBlocState(MovieReviewBlocStatus.initial)) {
    on<SaveReviewEvent>(
      (event, emit) async {
        emit(const MovieReviewBlocState(MovieReviewBlocStatus.loading));

        final response = await _usecase.saveReview(event.review);

        response.resolve(
            onFail: (err) =>
                emit(const MovieReviewBlocState(MovieReviewBlocStatus.failed)),
            onSuccess: (data) => emit(MovieReviewBlocState(
                MovieReviewBlocStatus.loaded,
                movieReview: event.review)));
      },
    );

    on<GetReviewEvent>(
      (event, emit) async {
        emit(const MovieReviewBlocState(MovieReviewBlocStatus.loading));

        final response = await _usecase.getReview(event.movieId);

        response.resolve(
            onFail: (err) =>
                emit(const MovieReviewBlocState(MovieReviewBlocStatus.failed)),
            onSuccess: (data) => emit(MovieReviewBlocState(
                MovieReviewBlocStatus.loaded,
                movieReview: data)));
      },
    );
  }
}
