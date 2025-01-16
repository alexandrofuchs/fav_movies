import 'package:fav_movies/core/common/models/movie.dart';
import 'package:fav_movies/core/themes/app_fonts.dart';
import 'package:fav_movies/core/widgets/buttons/default_main_button.dart';
import 'package:fav_movies/core/widgets/common/common_widgets.dart';
import 'package:fav_movies/core/widgets/loading/app_loading_dots_widget.dart';
import 'package:fav_movies/core/widgets/scaffolds/home_scaffold.dart';
import 'package:fav_movies/core/widgets/movies/favorite_action.dart';
import 'package:fav_movies/core/widgets/movies/movie_widgets.dart';
import 'package:fav_movies/modules/watchlist/presenter/blocs/load_watchlist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class WatchListPage extends StatefulWidget {
  const WatchListPage({super.key});

  @override
  State<StatefulWidget> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<WatchListPage> with CommonWidgets, FavoriteAction, MovieWidgets {
  final bloc = LoadWatchListBloc(Modular.get());

  @override
  void initState() {
    bloc.add(LoadMoviesEvent());
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  Widget loadedWidget(List<Movie> movies) =>
    
   movies.isEmpty
      ? Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Nenhum filme adicionado a lista para assistir.',
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
          itemBuilder: (context, index) => 
          favoriteListener(child: cardWidget(index, movies[index]),
        ));

  @override
  Widget build(BuildContext context) {
    return HomeScaffold(
        appBar: AppBar(
          title: titleDot('Lista para assistir', true),
        ),
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: BlocBuilder<LoadWatchListBloc, LoadWatchListBlocState>(
              bloc: bloc,
              builder: (context, state) => switch (state.status) {
                    LoadWatchListBlocStatus.loading => const AppLoadingDots(),
                    LoadWatchListBlocStatus.failed => errorMessageWidget(
                        'Não foi possível carregar sua lista para assistir'),
                    LoadWatchListBlocStatus.loaded =>
                      loadedWidget(state.sourceList!),
                  }),
        ));
  }
}
