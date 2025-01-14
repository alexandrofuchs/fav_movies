import 'package:fav_movies/core/common/models/movie.dart';
import 'package:fav_movies/core/themes/app_colors.dart';
import 'package:fav_movies/core/themes/app_fonts.dart';
import 'package:fav_movies/core/widgets/buttons/default_main_button.dart';
import 'package:fav_movies/core/widgets/common/common_widgets.dart';
import 'package:fav_movies/core/widgets/loading/app_loading_dots_widget.dart';
import 'package:fav_movies/modules/details/domain/models/movie_details.dart';
import 'package:fav_movies/modules/details/presenter/blocs/movie_details/movie_details_bloc.dart';
import 'package:fav_movies/modules/details/presenter/blocs/movie_review/movie_review_bloc.dart';
import 'package:fav_movies/modules/details/presenter/blocs/watch_list/manage_watchlist_bloc.dart';
import 'package:fav_movies/modules/details/presenter/pages/widgets/review_movie/movie_review_widget.dart';
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
    with MovieWidgets, CommonWidgets, MovieReviewWidget {
  final bloc = MovieDetailsBloc(Modular.get());
  final watchListBloc = ManageWatchlistBloc(Modular.get());

  @override
  void initState() {
    bloc.add(GetMovieDetailsEvent(widget.movie.id));
    reviewBloc.add(GetReviewEvent(widget.movie.id));
    watchListBloc.add(VerifyWatchlistEvent(widget.movie.id));
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    rate.dispose();
    reviewBloc.close();
    watchListBloc.close();
    super.dispose();
  }

  Widget infoWidget(MovieDetails movieDetails) => Flexible(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.movie.title,
              style: AppTextStyles.titleMedium,
              softWrap: true,
              maxLines: 2,
            ),
            Text('${movieDetails.genre.join(', ')};'),
            showRateWidget(),
          ],
        ),
      );

  Widget overviewWidget() => Container(
      decoration: BoxDecoration(
        color: AppColors.secundaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.all(25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          itemDot('Sinopse: ', bold: true),
          Text(
            widget.movie.overview,
            style: AppTextStyles.bodySmall,
          )
        ],
      ));

  Widget loadedWidget(MovieDetails movieDetails) => SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          cardWidget([
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                moviePosterWidget(),
                infoWidget(movieDetails),
              ],
            ),
            overviewWidget(),
          ]),
          actions(),
        ],
      ));

  Widget actions() => Column(children: [
        DefaultMainButton(
            label: 'Avaliar',
            onPressed: () {
              openReviewBottomSheet(context, widget.movie);
            }),
        BlocBuilder<ManageWatchlistBloc, ManageWatchlistBlocStatus>(
            bloc: watchListBloc,
            builder: (context, state) => switch (state) {
                  ManageWatchlistBlocStatus.initial => const SizedBox(),
                  ManageWatchlistBlocStatus.loading => const SizedBox(),
                  ManageWatchlistBlocStatus.inWatchList => DefaultMainButton(
                      label: 'Remover da lista de assistidos',
                      onPressed: () {
                        watchListBloc.add(RemoveFromWatchlistEvent(widget.movie.id));
                      }),
                  ManageWatchlistBlocStatus.notInWatchlist => DefaultMainButton(
                      label: 'Adicionar à lista de assistidos',
                      onPressed: () {
                        watchListBloc.add(AddToWatchlistEvent(widget.movie));
                      }),
                }),
      ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.secundaryColor,
        appBar: AppBar(
          title: titleDot('Detalhes', true),
          foregroundColor: AppColors.secundaryColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: BlocBuilder<MovieDetailsBloc, MovieDetailsBlocState>(
              bloc: bloc,
              builder: (context, state) => switch (state.status) {
                    MovieDetailsBlocStatus.loading => const AppLoadingDots(),
                    MovieDetailsBlocStatus.failed => errorMessageWidget(
                        'Não foi possível carregar os detalhes do filme'),
                    MovieDetailsBlocStatus.loaded =>
                      loadedWidget(state.movieDetails!),
                  }),
        ));
  }
}
