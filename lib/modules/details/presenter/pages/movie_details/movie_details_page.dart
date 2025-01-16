import 'package:fav_movies/core/common/models/movie.dart';
import 'package:fav_movies/core/themes/app_colors.dart';
import 'package:fav_movies/core/themes/app_fonts.dart';
import 'package:fav_movies/core/widgets/buttons/default_main_button.dart';
import 'package:fav_movies/core/widgets/common/common_widgets.dart';
import 'package:fav_movies/core/widgets/loading/app_loading_dots_widget.dart';
import 'package:fav_movies/core/widgets/snackbars/app_snackbars.dart';
import 'package:fav_movies/core/widgets/youtube_player/youtube_player_widget.dart';
import 'package:fav_movies/modules/details/domain/models/movie_details.dart';
import 'package:fav_movies/modules/details/presenter/blocs/movie_details/movie_details_bloc.dart';
import 'package:fav_movies/modules/details/presenter/blocs/movie_review/movie_review_bloc.dart';
import 'package:fav_movies/modules/details/presenter/blocs/watch_list/manage_watchlist_bloc.dart';
import 'package:fav_movies/modules/details/presenter/pages/widgets/review_movie/movie_review_widget.dart';
import 'package:fav_movies/core/widgets/movies/favorite_action.dart';
import 'package:fav_movies/core/widgets/movies/movie_widgets.dart';
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
    with FavoriteAction, CommonWidgets, MovieWidgets,  MovieReviewWidget {
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

  Widget titleWidget() =>
    Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text(
          widget.movie.title,
          style: AppTextStyles.titleLarge.copyWith(fontWeight: FontWeight.bold),
          softWrap: true,
          maxLines: 2,
        ),
      );

  

  Widget infoWidget(MovieDetails movieDetails) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleWidget(),
        infoRow('Título original: ', widget.movie.originalTitle),
        infoRow('Gêneros: ', '${movieDetails.genre.join(', ')}.'),
        infoRow('Linguagem original: ', widget.movie.originalLanguage.label),
        infoRow('Avaliação média: ', widget.movie.voteAverage.toString()),
        infoRow('Data Lançamento: ', widget.movie.releaseDate),
      ],
    ),
  );

  Widget overviewWidget(MovieDetails movieDetails) => Column(
    children: [
      Container(
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
                textAlign: TextAlign.justify,
                style: AppTextStyles.bodyMedium,
                
              ),
              
              movieDetails.trailer.isEmpty ?
                const SizedBox() :
               videoTrailer(movieDetails.trailer.first.key),
            ],
          )),
        divider(),
    ],
  );

  

  Widget loadedWidget(MovieDetails movieDetails) => SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children:[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                moviePosterWidget(widget.movie.posterPath),
                Expanded(child: infoWidget(movieDetails)),
              ],
            ),
            divider(),
            showRateWidget(showDescription: true),
            overviewWidget(movieDetails),
          ]),
          actions(),
        ],
      ));

  Widget actions() => Column(children: [
        DefaultMainButton(
            label: 'Avaliar',
            leftIcon: Icons.star,
            onPressed: () {
              openReviewBottomSheet(context, widget.movie);
            }),
        BlocConsumer<ManageWatchlistBloc, ManageWatchlistBlocStatus>(
          listener: (context, state) => switch(state){
            ManageWatchlistBlocStatus.initial => null,
            ManageWatchlistBlocStatus.loading => null,
            ManageWatchlistBlocStatus.inWatchList => AppSnackbars.showSuccessSnackbar(context, 'Filme adicionado na lista para assistir.'),
            ManageWatchlistBlocStatus.notInWatchlist => AppSnackbars.showSuccessSnackbar(context, 'Filme removido da lista para assistir.'),
          },
            bloc: watchListBloc,
            builder: (context, state) => switch (state) {
                  ManageWatchlistBlocStatus.initial => const SizedBox(),
                  ManageWatchlistBlocStatus.loading => const SizedBox(),
                  ManageWatchlistBlocStatus.inWatchList => DefaultMainButton(
                      label: 'Remover da lista para assistir',
                      leftIcon: Icons.tv_off,
                      onPressed: () {
                        watchListBloc.add(RemoveFromWatchlistEvent(widget.movie.id));
                      }),
                  ManageWatchlistBlocStatus.notInWatchlist => DefaultMainButton(
                      label: 'Adicionar à lista para assistir',
                      leftIcon: Icons.tv,
                      onPressed: () {
                        watchListBloc.add(AddToWatchlistEvent(widget.movie));
                      }),
                }),
      ]);

  Widget videoTrailer(String videoId) =>
    Column(
        children: [
          itemDot('Trailer'),
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: AppColors.primaryColor, width: 5),
        color: AppColors.secundaryColor,
      ),
      
      child: 
          YoutubePlayerWidget(videoId: videoId),
    )],
      
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.secundaryColor,
        appBar: AppBar(
          title: titleDot('Detalhes', true),
          foregroundColor: AppColors.secundaryColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
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
