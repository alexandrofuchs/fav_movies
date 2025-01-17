import 'package:fav_movies/core/common/models/movie.dart';
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
    with CommonWidgets, FavoriteAction, MovieWidgets, NavigationRoutes, SearchWidgets {
  final PopularMoviesBloc popularMoviesBloc = PopularMoviesBloc(Modular.get());

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
    focusedCardIndex.dispose();
    super.dispose();
  }

  Widget loadedWidget(List<Movie> movieList) => 
    Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        searchBar('Pesquisar filme...', (value){
          popularMoviesBloc.add(SearchByTextEvent(value));
        },
        margin: EdgeInsets.zero,
        ),
    movieList.isEmpty
      ? const Padding(
        padding: EdgeInsets.only(left: 25, right: 25),
        child: Center(
            child: Text(
                    'Nenhum filme foi retornado na lista.',
                    style: AppTextStyles.labelLarge,
                  ),
                ),
      ) :
    
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: movieList.length,
                itemBuilder: (context, index) =>
                    cardWidget(index, movieList[index]),
              ),
          ),
        ),
        const SizedBox()
      ],
    );

  @override
  Widget build(BuildContext context) {
    return HomeScaffold(
      appBar: AppBar(
        title: titleDot('Filmes populares', true),
      ),
      body: favoriteListener(
        child: BlocBuilder<PopularMoviesBloc, PopularMoviesBlocState>(
            bloc: popularMoviesBloc,
            builder: (context, state) => switch (state.status) {
                  PopularMoviesBlocStatus.firstLoading => const AppLoadingDots(),
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
