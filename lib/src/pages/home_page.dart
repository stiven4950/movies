import 'package:flutter/material.dart';
import 'package:movies/src/providers/movie_provider.dart';
import 'package:movies/src/search/search_delegate.dart';
import 'package:movies/src/widgets/card_swiper.dart';
import 'package:movies/src/widgets/movie_slider.dart';

import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static final route = 'home/';

  final movieProvider = new MovieProvider();

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Películas en cines"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: MovieSearchDelegate(),
                //query: "Buscar",
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: 10.0),
              CardSwiper(movies: movieProvider.onDisplayMovies),
              SizedBox(height: 10.0),
              MovieSlider(
                movies: movieProvider.popularMovies,
                title: 'Populares',
                onNextPage: () => movieProvider.getPopularMovies(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
