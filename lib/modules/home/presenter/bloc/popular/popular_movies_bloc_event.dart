part of 'popular_movies_bloc.dart';

class GetMoviesEvent extends Equatable {
  final int page;

  const GetMoviesEvent(this.page);

  @override
  List<Object?> get props => [page];
}