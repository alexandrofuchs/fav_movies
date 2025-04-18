import 'package:fav_movies/core/common/models/movie.dart';
import 'package:fav_movies/core/themes/app_colors.dart';
import 'package:fav_movies/core/themes/app_fonts.dart';
import 'package:fav_movies/core/widgets/common/common_widgets.dart';
import 'package:fav_movies/core/widgets/loading/app_loading_dots_widget.dart';
import 'package:fav_movies/core/widgets/scaffolds/blocs/bottom_navigator_bloc.dart';
import 'package:fav_movies/core/widgets/scaffolds/home_scaffold.dart';
import 'package:fav_movies/core/widgets/search_widgets/search_widgets.dart';
import 'package:fav_movies/modules/home/presenter/bloc/popular/popular_movies_bloc.dart';
import 'package:fav_movies/core/widgets/movies/favorite_action.dart';
import 'package:fav_movies/core/widgets/movies/movie_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PopularMoviesPage extends StatefulWidget {
  const PopularMoviesPage({super.key});

  @override
  State<StatefulWidget> createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage>
    with
        CommonWidgets,
        FavoriteAction,
        MovieWidgets,
        NavigationRoutes,
        SearchWidgets {
  final PopularMoviesBloc popularMoviesBloc = PopularMoviesBloc(Modular.get());

  final ValueNotifier<bool> showSearchBar = ValueNotifier(false);
  @override
  void initState() {
    Modular.get<BottomNavigatorBloc>()
        .loadNavigationRoutes(getUserNavigations());
    popularMoviesBloc.add(const GetMoviesEvent(1));

    super.initState();
  }

  @override
  void dispose() {
    popularMoviesBloc.close();
    showSearchBar.dispose();
    focusedCardIndex.dispose();
    super.dispose();
  }

  Widget loadedWidget(List<Movie> movieList) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          movieList.isEmpty
              ? const Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Center(
                    child: Text(
                      'Nenhum filme foi retornado na lista.',
                      style: AppTextStyles.labelLarge,
                    ),
                  ),
                )
              : Expanded(
                  child: Container(
                    color: Colors.black,
                    padding:
                        const EdgeInsets.only(left: 5, right: 5, bottom: 5),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: movieList.length,
                      itemBuilder: (context, index) =>
                          cardWidget(context, index, movieList[index]),
                    ),
                  ),
                ),
          const SizedBox()
        ],
      );

  @override
  Widget build(BuildContext context) {
    return HomeScaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
          title: ValueListenableBuilder(
        valueListenable: showSearchBar,
        builder: (context, show, child) => AnimatedCrossFade(
            firstChild: Row(
              children: [
                Expanded(child: titleDot('Filmes populares')),
                IconButton(
                  onPressed: () {
                    showSearchBar.value = !show;
                  },
                  icon: const Icon(
                    Icons.search,
                    size: 24,
                  ),
                ),
              ],
            ),
            secondChild: searchBarContainer(searchBar(
              'Pesquisar em filmes polulares',
              (value) {
                popularMoviesBloc.add(SearchByTextEvent(value));
              },
              onClearText: () {
                showSearchBar.value = false;
              }),
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero
            ),
            crossFadeState:
                show ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300)),
      )),
      body: favoriteListener(
        child: BlocBuilder<PopularMoviesBloc, PopularMoviesBlocState>(
            bloc: popularMoviesBloc,
            builder: (context, state) => switch (state.status) {
                  PopularMoviesBlocStatus.firstLoading =>
                    const AppLoadingDots(),
                  PopularMoviesBlocStatus.loadingMore => const AppLoadingDots(),
                  PopularMoviesBlocStatus.failed => errorMessageWidget(
                      'Não foi possível carregar a lista de filmes.'),
                  PopularMoviesBlocStatus.loaded =>
                    loadedWidget(state.filteredList)
                }),
      ),
    );
  }
}
