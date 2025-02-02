import 'package:fav_movies/core/common/models/movie.dart';
import 'package:fav_movies/core/themes/app_fonts.dart';
import 'package:fav_movies/core/widgets/appbar_widgets/default_appbar_widgets.dart';
import 'package:fav_movies/core/widgets/buttons/default_main_button.dart';
import 'package:fav_movies/core/widgets/common/common_widgets.dart';
import 'package:fav_movies/core/widgets/loading/app_loading_dots_widget.dart';
import 'package:fav_movies/core/widgets/scaffolds/home_scaffold.dart';
import 'package:fav_movies/modules/favorites/presenter/blocs/load_favorite_movies_bloc.dart';
import 'package:fav_movies/core/widgets/movies/favorite_action.dart';
import 'package:fav_movies/core/widgets/movies/movie_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<StatefulWidget> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritesPage> with DefaultAppbarWidgets, CommonWidgets, FavoriteAction, MovieWidgets {
  final LoadFavoriteMoviesBloc bloc = Modular.get();

  @override
  void initState() {
    bloc.add(LoadMoviesEvent());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget loadedWidget(List<Movie> movies) => movies.isEmpty
      ? Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Nenhum filme adicionado aos favoritos.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.labelLarge.copyWith(),
                ),
                DefaultMainButton(
                    leftIcon: Icons.arrow_back,
                    onPressed: () {
                      Modular.to.navigate('/home/');
                    },
                    label: 'Voltar para o início')
              ]),
        )
      : ListView.builder(
          shrinkWrap: true,
          itemCount: movies.length,
          itemBuilder: (context, index) => cardWidget(context, index, movies[index]),
        );

  @override
  Widget build(BuildContext context) {
    return HomeScaffold(
        appBar: AppBar(
          title: titleDot('Favoritos'),
        ),
        body: favoriteListener(child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.black,
                padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
                child: BlocBuilder<LoadFavoriteMoviesBloc, LoadFavoriteBlocState>(
                    bloc: bloc,
                    builder: (context, state) => switch (state.status) {
                          LoadFavoriteBlocStatus.loading => const AppLoadingDots(),
                          LoadFavoriteBlocStatus.failed => errorMessageWidget(
                              'Não foi possível carregar os favoritos'),
                          LoadFavoriteBlocStatus.loaded =>
                            loadedWidget(state.sourceList!),
                        }),
              ),
            ),
          ],
        )));
  }
}
