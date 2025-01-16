import 'package:fav_movies/core/common/models/movie.dart';
import 'package:fav_movies/core/themes/app_colors.dart';
import 'package:fav_movies/core/themes/app_fonts.dart';
import 'package:fav_movies/core/widgets/buttons/default_main_button.dart';
import 'package:fav_movies/core/widgets/common/common_widgets.dart';
import 'package:fav_movies/core/widgets/movies/favorite_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_modular/flutter_modular.dart';

mixin MovieWidgets on FavoriteAction, CommonWidgets {
  final ValueNotifier<int> focusedCardIndex = ValueNotifier(0);

  Widget favoriteIconButton(Function() favoriteAction) => Row(
        children: [
          IconButton(
            padding: const EdgeInsets.all(0),
            onPressed: favoriteAction,
            icon: const Icon(
              Icons.favorite,
              color: AppColors.successColor,
              size: 24,
            ),
          ).animate().scaleXY(
              begin: 0.2, end: 1, duration: const Duration(milliseconds: 1000)),
        ],
      );

  Widget firstCardHeader(String title, Function() favoriteAction) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Text(
                title,
                softWrap: true,
                maxLines: 2,
                style: AppTextStyles.titleMedium
                    .copyWith(fontWeight: FontWeight.w700),
              ),
            ),
          ),
          favoriteIconButton(favoriteAction),
        ],
      );

  Widget contentTextItem(String label, String text) => Flexible(
        child: Column(
          children: [
            Text(
              label,
              style: AppTextStyles.bodySmall.copyWith(),
              softWrap: true,
              maxLines: 2,
            ),
            Text(
              text,
              style:
                  AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      );

  Widget firstCardContent(Movie movie) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                contentTextItem('Avaliação', movie.voteAverage.toStringAsFixed(1)),
                contentTextItem('Idioma', movie.originalLanguage.label),
                contentTextItem('Data', movie.releaseDate),
                contentTextItem('Adulto', movie.adult ? 'Sim' : 'Não'),
              ],
            ),
          ),
          DefaultMainButton(
              label: 'Ver detalhes',
              compact: true,
              secundaryColor: AppColors.secundaryColor,
              onPressed: () {
                Modular.to.pushNamed('/details/', arguments: movie);
              })
        ],
      );

  Widget moviePosterWidget(String? path,
          {double height = 100, double width = 100}) =>
      ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: path != null
              ? Image.network(
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }

                    return Container(
                      decoration: BoxDecoration(
                        color: AppColors.secundaryColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      height: height,
                      width: width,
                    ).animate().show();
                  },
                  path,
                  fit: BoxFit.fitWidth,
                  width: width,
                )
              : SizedBox(
                  height: height,
                  width: width,
                ));

  Widget otherCardContent(Movie movie) => Container(
        color: AppColors.secundaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(
                    top: 15, left: 5, bottom: 15, right: 10),
                child: moviePosterWidget(
                  movie.posterPath,
                  width: 100,
                )),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: AppTextStyles.titleMedium
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 10),
                    infoRow(
                      'Nota: ',
                      movie.voteAverage.toStringAsFixed(1),
                    ),
                    infoRow('Data: ', movie.releaseDate),
                    infoRow('Idioma: ', movie.originalLanguage.label),
                    infoRow('Adulto: ', movie.adult ? 'Sim' : 'Não'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        favoriteIconButton(() => favoriteAction(movie)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  Widget cardContainer(List<Widget> children,
          {Color backgroundColor = AppColors.secundaryColor}) =>
      Center(
        child: Container(
          margin: const EdgeInsets.only(top: 15, bottom: 5, left: 15, right: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(
                spreadRadius: 1,
                blurRadius: 5,
                color: AppColors.secundaryColor,
              )
            ],
            color: AppColors.secundaryColor,
          ),
          child: Column(
            children: children,
          ),
        ).animate().shimmer(duration: const Duration(seconds: 2)),
      );

  Widget cardWidget(int index, Movie movie) => ValueListenableBuilder(
      valueListenable: focusedCardIndex,
      builder: (context, value, child) => AnimatedCrossFade(
            crossFadeState: value == index
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 300),
            alignment: Alignment.center,
            firstChild: focusedMovieItem(movie),
            secondChild: otherMovieItem(index, movie),
          ));

  Widget focusedMovieItem(Movie movie) => cardContainer([
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: moviePosterWidget(movie.posterPath, width: 250),
        ),
        firstCardHeader(movie.title, () => favoriteAction(movie)),
        firstCardContent(movie),
      ]);

  Widget otherMovieItem(int index, Movie movie) => GestureDetector(
        onTap: () {
          focusedCardIndex.value = index;
        },
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              boxShadow: const [
                BoxShadow(
                  spreadRadius: 1,
                  blurRadius: 2,
                  color: AppColors.primaryColorLight,
                )
              ],
              color: AppColors.secundaryColor,
            ),
            child: Container(
              padding: const EdgeInsets.all(5),
              child: otherCardContent(movie),
            ),
          ),
        ),
      );
}
