import 'package:fav_movies/core/common/models/models/movie.dart';
import 'package:fav_movies/core/themes/app_colors.dart';
import 'package:fav_movies/core/themes/app_fonts.dart';
import 'package:fav_movies/core/widgets/buttons/default_main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

mixin MovieWidgets {
  Widget firstCardHeader(String title, Function() favoriteAction) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Text(
            title,
            style: AppTextStyles.titleMedium,
          )),
          IconButton(onPressed: favoriteAction, icon: const Icon(Icons.favorite)),
        ],
      );

  Widget firstCardContent(Movie movie) => Column(
    children: [
      Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Image.asset(
                'assets/images/cover_example.png',
                fit: BoxFit.fitHeight,
                height: 250,
              ),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Genero: Aventura'),
                    ],
                  ),
                ),
              )
            ],
          ),
        DefaultMainButton(label: 'Ver detalhes', onPressed: (){
          Modular.to.navigate('/details/', arguments: movie);
        })
    ],
  );

  Widget moviePosterWidget() =>
     Image.asset(
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
            child: moviePosterWidget()
          ),
           Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title,style: AppTextStyles.titleSmall,
                  ),
                ],
              ),
            ),
          ),
          const Icon(Icons.favorite),
        ],
      );

  Widget cardWidget(List<Widget> children) => Card(
        margin: const EdgeInsets.only(top: 15, bottom: 5),
        color: AppColors.secundaryColor,
        elevation: 5,
        child: Container(
          margin: const EdgeInsets.all(15),
          child: Column(
            children: children,
          ),
        ),
      );
}
