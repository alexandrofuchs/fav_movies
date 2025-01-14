import 'package:fav_movies/core/common/models/models/movie.dart';
import 'package:fav_movies/core/widgets/common/common_widgets.dart';
import 'package:fav_movies/core/widgets/loading/app_loading_dots_widget.dart';
import 'package:fav_movies/core/widgets/scaffolds/blocs/bottom_navigator_bloc.dart';
import 'package:fav_movies/core/widgets/scaffolds/home_scaffold.dart';
import 'package:fav_movies/core/widgets/snackbars/app_snackbars.dart';
import 'package:fav_movies/modules/home/presenter/bloc/favorite/favorite_movie_bloc.dart';
import 'package:fav_movies/modules/home/presenter/bloc/popular/popular_movies_bloc.dart';
import 'package:fav_movies/modules/home/presenter/pages/popular_movies/widgets/movie_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PopularMoviesPage extends StatefulWidget {
  const PopularMoviesPage({super.key});

  @override
  State<StatefulWidget> createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage>
    with CommonWidgets, MovieWidgets, NavigationRoutes {
  final PopularMoviesBloc popularMoviesBloc = PopularMoviesBloc(Modular.get());
  final FavoriteMovieBloc favoriteMovieBloc = FavoriteMovieBloc(Modular.get());

  @override
  void initState() {
    Modular.get<BottomNavigatorBloc>()
        .loadNavigationRoutes(getUserNavigations());
    popularMoviesBloc.add(const GetMoviesEvent(1));
    super.initState();
  }

  @override
  void dispose() {
    popularMoviesBloc.close();
    favoriteMovieBloc.close();
    super.dispose();
  }

  void favoriteAction(Movie movie) {
    favoriteMovieBloc.add(SaveMovieEvent(movie));
  }

  Widget firstMovieItem(Movie movie) => cardWidget([
        firstCardHeader(movie.title, () => favoriteAction(movie)),
        firstCardContent()
      ]);

  Widget otherMovieItem(Movie movie) => cardWidget([otherCardContent(movie)]);

  @override
  Widget build(BuildContext context) {
    return HomeScaffold(
      appBar: AppBar(
        title: const Text('Filmes populares'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(25),
          child: BlocListener<FavoriteMovieBloc, FavoriteMovieBlocStatus>(
            bloc: favoriteMovieBloc,
            listenWhen: (previous, current) =>
                current == FavoriteMovieBlocStatus.failed ||
                current == FavoriteMovieBlocStatus.saved,
            listener: (context, state) => switch (state) {
              FavoriteMovieBlocStatus.initial => null,
              FavoriteMovieBlocStatus.saving => null,
              FavoriteMovieBlocStatus.failed => AppSnackbars.showErrorSnackbar(
                  context, 'Não foi possível favoritar.'),
              FavoriteMovieBlocStatus.saved => AppSnackbars.showSuccessSnackbar(
                  context, 'Filme salvo nos favoritos'),
            },
            child: BlocBuilder<PopularMoviesBloc, PopularMoviesBlocState>(
                bloc: popularMoviesBloc,
                builder: (context, state) => switch (state.status) {
                      PopularMoviesBlocStatus.firstLoading =>
                        const AppLoadingDots(),
                      PopularMoviesBlocStatus.loadingMore =>
                        const AppLoadingDots(),
                      PopularMoviesBlocStatus.failed => errorMessageWidget(
                          'Não foi possível carregar a lista de filmes.'),
                      PopularMoviesBlocStatus.loaded => ListView.builder(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: state.popularMovies!.list.length,
                          itemBuilder: (context, index) => index == 0
                              ? firstMovieItem(state.popularMovies!.list[index])
                              : otherMovieItem(
                                  state.popularMovies!.list[index]),
                        ),
                    }),
          )),
    );
  }
}
