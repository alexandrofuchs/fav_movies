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
              color: AppColors.orangeColor,
              size: 24,
            ),
          ).animate().scaleXY(
              begin: 0.2, end: 1, duration: const Duration(milliseconds: 1000)),
        ],
      );

  Widget focusedCardHeader(String title, Function() favoriteAction) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Text(
                title,
                softWrap: true,
                maxLines: 2,
                style: AppTextStyles.labelMedium.copyWith(
                    fontWeight: FontWeight.w400,
                    wordSpacing: 1,
                    letterSpacing: 1),
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
              style: AppTextStyles.labelSmall
                  .copyWith(color: AppColors.primaryColorLight, fontSize: 8),
              softWrap: true,
              maxLines: 1,
            ),
            Text(
              text,
              softWrap: false,
              overflow: TextOverflow.fade,
              style: AppTextStyles.labelSmall
                  .copyWith(fontSize: 10, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      );

  Widget focusedCardContent(BuildContext context, Movie movie) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                contentTextItem(
                    'Avaliação', movie.voteAverage.toStringAsFixed(1)),
                contentTextItem('Idioma', movie.originalLanguage.label),
                contentTextItem('Data', movie.releaseDate),
                contentTextItem('Adulto', movie.adult ? 'Sim' : 'Não'),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: DefaultMainButton(
                label: 'Ver detalhes',
                margin: EdgeInsets.zero,
                boldText: false,
                expandedWidth: true,
                iconColor: Colors.transparent,
                leftIcon: Icons.more_horiz,
                shape: const RoundedRectangleBorder(),
                invertColors: true,
                primaryColor: AppColors.orangeColor,
                secundaryColor: Colors.transparent,
                onPressed: () {
                  Modular.to.pushNamed('/details/', arguments: movie);
                }),
          )
        ],
      );

  Widget moviePosterWidget(String? path,
          {double height = 100,
          double width = 100,
          BorderRadius borderRadius = BorderRadius.zero}) =>
      ClipRRect(
          borderRadius: borderRadius,
          child: path != null
              ? Image.network(
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }

                    return Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      height: height,
                      width: width,
                    );
                  },
                  path,
                  fit: BoxFit.fitWidth,
                  width: width,
                )
              : SizedBox(
                  height: height,
                  width: width,
                ));

  Widget otherCardContent(Movie movie) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(right: 10),
              child: moviePosterWidget(
                movie.posterPath,
                width: 100,
              )),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Text(
                  movie.title,
                  style: AppTextStyles.labelMedium.copyWith(
                      fontWeight: FontWeight.w500,
                      wordSpacing: 1,
                      letterSpacing: 1),
                ),
                const SizedBox(
                  height: 25,
                ),
                infoRow(
                  'Avaliação: ',
                  movie.voteAverage.toStringAsFixed(1),
                ),
                const SizedBox(
                  height: 5,
                ),
                infoRow('Data: ', movie.releaseDate),
                const SizedBox(
                  height: 5,
                ),
                infoRow('Idioma: ', movie.originalLanguage.label),
                const SizedBox(
                  height: 5,
                ),
                infoRow('Adulto: ', movie.adult ? 'Sim' : 'Não'),
              ],
            ),
          ),
          favoriteIconButton(() => favoriteAction(movie)),
        ],
      );

  Widget firstCardContainer(List<Widget> children) => Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 5),
        padding: const EdgeInsets.only(top: 1, left: 1, right: 1),
        decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: AppColors.orangeColor, width: 0.5),
              left: BorderSide(color: AppColors.orangeColor, width: 0.5),
              right: BorderSide(color: AppColors.orangeColor, width: 0.5),
              top: BorderSide(color: AppColors.orangeColor, width: 0.5),
            ),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.75, 1],
                colors: [AppColors.primaryColorDark, AppColors.primaryColor])),
        child: Column(
          children: children,
        ),
      ).animate().shimmer(duration: const Duration(seconds: 2));

  Widget cardWidget(BuildContext context, int index, Movie movie) => Center(
        child: ValueListenableBuilder(
            valueListenable: focusedCardIndex,
            builder: (context, value, child) => AnimatedCrossFade(
                  crossFadeState: value == index
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: const Duration(milliseconds: 300),
                  alignment: Alignment.center,
                  firstChild: focusedMovieItem(context, movie),
                  secondChild: otherMovieItem(index, movie),
                )),
      );

  Widget focusedMovieItem(BuildContext context, Movie movie) =>
      firstCardContainer([
        moviePosterWidget(movie.posterPath,
            width: MediaQuery.of(context).size.width),
        focusedCardHeader(movie.title, () => favoriteAction(movie)),
        focusedCardContent(context, movie)
      ]);

  Widget otherMovieItem(int index, Movie movie) => GestureDetector(
        onTap: () {
          focusedCardIndex.value = index;
        },
        child: Container(
          margin: const EdgeInsets.only(top: 5, bottom: 0),
          decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(color: AppColors.orangeColor, width: 0.5)),
            color: AppColors.primaryColorDark,
          ),
          child: otherCardContent(movie),
        ),
      );
}
