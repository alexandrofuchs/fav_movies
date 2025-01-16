import 'package:fav_movies/core/common/models/movie.dart';
import 'package:fav_movies/core/themes/app_fonts.dart';
import 'package:fav_movies/core/widgets/common/common_widgets.dart';
import 'package:fav_movies/core/widgets/loading/app_loading_dots_widget.dart';
import 'package:fav_movies/core/widgets/scaffolds/home_scaffold.dart';
import 'package:fav_movies/core/widgets/search_widgets/search_widgets.dart';
import 'package:fav_movies/core/widgets/movies/favorite_action.dart';
import 'package:fav_movies/core/widgets/movies/movie_widgets.dart';
import 'package:fav_movies/modules/search/presenter/bloc/search_movie_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SearchMoviePage extends StatefulWidget {
  const SearchMoviePage({super.key});

  @override
  State<StatefulWidget> createState() => _SearchMoviePageState();
}

class _SearchMoviePageState extends State<SearchMoviePage>
    with CommonWidgets, SearchWidgets, FavoriteAction, MovieWidgets {
  final bloc = SearchMovieBloc(Modular.get());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    searchBarController.dispose();
    focusedCardIndex.dispose();
    super.dispose();
  }

  Widget loadedWidget(List<Movie> movieList) => movieList.isEmpty ? const Center(child: Text('Nenhum filme encontrado.', style: AppTextStyles.labelLarge,)) : ListView.builder(
      shrinkWrap: true,
      itemCount: movieList.length,
      itemBuilder: (context, index) =>
          cardWidget(index, movieList[index]));

  @override
  Widget build(BuildContext context) {
    return HomeScaffold(
        appBar: AppBar(
          title: titleDot('Pesquisar Filme', true),
        ),
        body: Column(
          children: [
            searchBar('Pesquisar...', (value) {
              bloc.add(SearchEvent(value));
            }),
            Expanded(child: favoriteListener(child: BlocConsumer<SearchMovieBloc, SearchMovieBlocState>(
                bloc: bloc,
                listenWhen: (previous, current) => current.status == SearchMovieBlocStatus.loaded,
                listener: (context, state) {
                  focusedCardIndex.value = 0;
                },
                builder: (context, state) => switch (state.status) {
                      SearchMovieBlocStatus.initial =>   Center(
                        child: Container(
                          alignment: Alignment.center,
                          child: 
                        const Text('Digite um filme no campo de pesquisa.', style: AppTextStyles.labelLarge, textAlign: TextAlign.center,)),
                      ) ,
                      SearchMovieBlocStatus.loading => const AppLoadingDots(),
                      SearchMovieBlocStatus.failed => errorMessageWidget(
                          'Não foi possível efetuar a pesquisa!'),
                      SearchMovieBlocStatus.loaded =>
                        loadedWidget(state.filteredList),
                    })),
        )],
        ));
  }
}
