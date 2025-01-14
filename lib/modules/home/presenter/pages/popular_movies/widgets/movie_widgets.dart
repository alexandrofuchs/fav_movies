import 'package:fav_movies/core/common/models/movie.dart';
import 'package:fav_movies/core/themes/app_colors.dart';
import 'package:fav_movies/core/themes/app_fonts.dart';
import 'package:fav_movies/core/widgets/buttons/default_main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

mixin MovieWidgets {
  final ValueNotifier<int> focusedCardIndex = ValueNotifier(0);

  Widget firstCardHeader(String title, Function() favoriteAction) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
                      title,
                      style: AppTextStyles.titleMedium,
                    ),
          IconButton(
              onPressed: favoriteAction, icon: const Icon(Icons.favorite)),
        ],
      );

  Widget contentTextItem(String label, String text) =>
   RichText(
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
          Image.asset(
            'assets/images/cover_example.png',
            fit: BoxFit.fitHeight,
            height: 400,
          ),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              color: AppColors.backgroundColor,
              boxShadow: [
                BoxShadow(offset: Offset(0, 2), blurRadius: 2, spreadRadius: -2)
              ]
            ),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                contentTextItem('Média de votos: ', '${movie.voteAverage}'),
                contentTextItem('Linguagem Origem: ', movie.originalLanguage),
                contentTextItem('Lançamento: ', movie.releaseDate),
                contentTextItem('Na lista de favoritos: ', movie.savedInFavorites ? 'Sim' : 'Não'),
                contentTextItem('Na lista para assistir: ', movie.savedInWatchlist ? 'Sim' : 'Não'),
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

  Widget moviePosterWidget() => Image.asset(
        'assets/images/cover_example.png',
        fit: BoxFit.fitHeight,
        height: 150,
      );

  Widget otherCardContent(Movie movie) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              decoration: BoxDecoration(
                  color: AppColors.secundaryColor,
                  border: Border.all(color: AppColors.primaryColor, width: 10),
                  borderRadius: BorderRadius.circular(2)),
              padding: const EdgeInsets.all(1.5),
              child: moviePosterWidget()),
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
          const Icon(Icons.favorite),
        ],
      );

  Widget cardWidget(List<Widget> children,
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
      );
}
