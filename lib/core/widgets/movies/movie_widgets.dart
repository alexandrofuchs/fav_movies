import 'package:fav_movies/core/common/models/movie.dart';
import 'package:fav_movies/core/themes/app_colors.dart';
import 'package:fav_movies/core/themes/app_fonts.dart';
import 'package:fav_movies/core/widgets/buttons/default_main_button.dart';
import 'package:fav_movies/core/widgets/movies/favorite_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_modular/flutter_modular.dart';

mixin MovieWidgets on FavoriteAction{
  final ValueNotifier<int> focusedCardIndex = ValueNotifier(0);

  Widget favoriteIconButton(Function() favoriteAction) =>
    IconButton(
              onPressed: favoriteAction, icon: const Icon(Icons.favorite));

  Widget firstCardHeader(String title, Function() favoriteAction) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              title,
              style: AppTextStyles.titleMedium,
            ),
          ),
          favoriteIconButton(favoriteAction),
        ],
      );

  Widget contentTextItem(String label, String text) => RichText(
        text: TextSpan(
          style: AppTextStyles.bodySmall,
          children: <TextSpan>[
            TextSpan(
                text: label,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: text),
          ],

        ),
      );

  Widget firstCardContent(Movie movie) => Column(
        children: [
          moviePosterWidget(movie.posterPath, height: 350),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
                color: AppColors.backgroundColor,
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 2), blurRadius: 2, spreadRadius: -2)
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                contentTextItem('Média de votos: ', '${movie.voteAverage}'),
                contentTextItem(
                    'Linguagem Origem: ', movie.originalLanguage.label),
                contentTextItem('Lançamento: ', movie.releaseDate),
                contentTextItem('Na lista de favoritos: ',
                    movie.savedInFavorites ? 'Sim' : 'Não'),
                contentTextItem('Na lista para assistir: ',
                    movie.savedInWatchlist ? 'Sim' : 'Não'),
              ],
            ),
          ),
          DefaultMainButton(
              label: 'Ver detalhes',
              onPressed: () {
                Modular.to.pushNamed('/details/', arguments: movie);
              })
        ],
      );

  Widget moviePosterWidget(String? path, {double height = 180}) => Padding(
        padding: const EdgeInsets.all(15),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: path != null ?
            
            Image.network(
              loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }

          return Center(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColorLight,
                borderRadius: BorderRadius.circular(5),
              ), height: 150, width: 100,).animate().show(),
          );},
              path,
              fit: BoxFit.fitHeight,
              height: height,
            ):  SizedBox(height: height, width: 100,) ),
      );

  Widget otherCardContent(Movie movie) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(1.5),
              child: moviePosterWidget(movie.posterPath)
                ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: AppTextStyles.titleSmall,
                  ),
                ],
              ),
            ),
          ),
          favoriteIconButton(() => favoriteAction(movie)),
        ],
      );

  Widget cardContainer(List<Widget> children,
          {Color backgroundColor = AppColors.backgroundColor}) =>
      Card(
        margin: const EdgeInsets.only(top: 15, bottom: 5),
        color: backgroundColor,
        elevation: 5,
        child: Container(
          margin: const EdgeInsets.all(15),
          child: Column(
            children: children,
          ),
        ),
      ).animate().shimmer(duration: const Duration(seconds: 2));

   

  Widget cardWidget(int index, Movie movie) => 
    ValueListenableBuilder(valueListenable:focusedCardIndex, builder:(context, value, child) => 
      AnimatedCrossFade(
      crossFadeState: value == index ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 300),
      firstChild: focusedMovieItem(movie),
      secondChild: otherMovieItem(index, movie),
    ));

  Widget focusedMovieItem(Movie movie) => cardContainer([
        firstCardHeader(movie.title, () => favoriteAction(movie)),
        firstCardContent(movie),
      ], backgroundColor: AppColors.secundaryColor);

  Widget otherMovieItem(int index, Movie movie) => GestureDetector(
    onTap: () {
      focusedCardIndex.value = index;
    },
    child: cardContainer([otherCardContent(movie)],
        backgroundColor: AppColors.secundaryColor),
  );
}
