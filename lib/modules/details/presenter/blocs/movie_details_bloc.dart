import 'package:equatable/equatable.dart';
import 'package:fav_movies/modules/details/domain/i_usecases/i_movie_details_usecase.dart';
import 'package:fav_movies/modules/details/domain/models/movie_details.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetMovieDetailsEvent extends Equatable {
  final int movieId;

  const GetMovieDetailsEvent(this.movieId);

  @override
  List<Object?> get props => [movieId];
}

enum MovieDetailsBlocStatus {
  loading,
  failed,
  loaded,
}

class MovieDetailsBlocState extends Equatable {
  final MovieDetailsBlocStatus status;
  final MovieDetails? movieDetails;

  const MovieDetailsBlocState(this.status, {this.movieDetails});

  @override
  List<Object?> get props => [status];
}

class MovieDetailsBloc extends Bloc<GetMovieDetailsEvent, MovieDetailsBlocState> {
  final IMovieDetailsUsecase _usecase;

  MovieDetailsBloc(this._usecase)
      : super(const MovieDetailsBlocState(MovieDetailsBlocStatus.loading)) {
    on<GetMovieDetailsEvent>((event, emit) async {
      final response = await _usecase.getDetails(event.movieId);

      response.resolve(
          onFail: (err) =>
              emit(const MovieDetailsBlocState(MovieDetailsBlocStatus.failed)),
          onSuccess: (data) => emit(MovieDetailsBlocState(
              MovieDetailsBlocStatus.loaded,
              movieDetails: data)));
    });
  }
}
