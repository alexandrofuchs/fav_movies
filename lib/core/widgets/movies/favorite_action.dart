import 'package:fav_movies/core/common/models/movie.dart';
import 'package:fav_movies/core/widgets/snackbars/app_snackbars.dart';
import 'package:fav_movies/modules/home/presenter/bloc/favorite/favorite_movie_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

mixin FavoriteAction {
  final FavoriteMovieBloc favoriteMovieBloc = Modular.get();
  
  void favoriteAction(Movie movie) {
    favoriteMovieBloc.add(SaveMovieEvent(movie));
  }

  favoriteListener({Widget? child}) =>
      BlocListener<FavoriteMovieBloc, FavoriteMovieBlocStatus>(
          bloc: favoriteMovieBloc,
          listenWhen: (previous, current) =>
              current == FavoriteMovieBlocStatus.failed ||
              current == FavoriteMovieBlocStatus.saved,
          listener: (context, state) => switch (state) {
                FavoriteMovieBlocStatus.initial => null,
                FavoriteMovieBlocStatus.saving => null,
                FavoriteMovieBlocStatus.failed =>
                  AppSnackbars.showErrorSnackbar(
                      context, 'Não foi possível favoritar.'),
                FavoriteMovieBlocStatus.saved =>
                  AppSnackbars.showSuccessSnackbar(
                      context, 'Filme salvo nos favoritos'),
              },
          child: child);
}