import 'package:fav_movies/modules/home/domain/i_usecase/i_popular_movies_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PopularMoviesPage extends StatefulWidget {
  const PopularMoviesPage({super.key});

  @override
  State<StatefulWidget> createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {

  final IPopularMoviesUsecase usecase = Modular.get();

  @override
  void initState() {
    usecase.getMovies(1);
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Popular movies'),),
    );
  }
}
