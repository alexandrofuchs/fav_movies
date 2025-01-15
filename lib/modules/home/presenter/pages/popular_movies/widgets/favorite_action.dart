import 'package:fav_movies/core/common/models/movie.dart';
import 'package:fav_movies/modules/home/presenter/bloc/favorite/favorite_movie_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

mixin FavoriteAction {
  final FavoriteMovieBloc favoriteMovieBloc = FavoriteMovieBloc(Modular.get());
  
  void favoriteAction(Movie movie) {
    favoriteMovieBloc.add(SaveMovieEvent(movie));
  }
}