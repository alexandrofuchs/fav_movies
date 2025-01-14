import 'package:fav_movies/core/common/models/models/movie.dart';
import 'package:fav_movies/core/widgets/common/common_widgets.dart';
import 'package:fav_movies/core/widgets/loading/app_loading_dots_widget.dart';
import 'package:fav_movies/modules/details/domain/models/movie_details.dart';
import 'package:fav_movies/modules/details/presenter/blocs/movie_details_bloc.dart';
import 'package:fav_movies/modules/home/presenter/pages/popular_movies/widgets/movie_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MovieDetailsPage extends StatefulWidget {
  final Movie movie;
  const MovieDetailsPage({super.key, required this.movie});

  @override
  State<StatefulWidget> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage>
    with MovieWidgets, CommonWidgets {
  final bloc = MovieDetailsBloc(Modular.get());

  @override
  void initState() {
    bloc.add(GetMovieDetailsEvent(widget.movie.id));
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  Widget loadedWidget(MovieDetails movieDetails) => SingleChildScrollView(
          child: cardWidget([
        Row(
          children: [
            moviePosterWidget(),
            Column(
              children: [
                Text(widget.movie.title),
              ],
            )
          ],
        ),
        Text(widget.movie.overview)
      ]));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<MovieDetailsBloc, MovieDetailsBlocState>(
            bloc: bloc,
            builder: (context, state) => switch (state.status) {
                  MovieDetailsBlocStatus.loading => const AppLoadingDots(),
                  MovieDetailsBlocStatus.failed => errorMessageWidget(
                      'Não foi possível carregar os detalhes do filme'),
                  MovieDetailsBlocStatus.loaded =>
                    loadedWidget(state.movieDetails!),
                }));
  }
}
