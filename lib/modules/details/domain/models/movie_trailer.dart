part of 'movie_details.dart';

class MovieTrailer extends Equatable{
  final String key;

  const MovieTrailer(this.key);
  
  @override
  List<Object?> get props => [key];
}