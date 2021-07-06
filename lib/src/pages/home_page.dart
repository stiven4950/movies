import 'package:flutter/material.dart';
import 'package:movies/src/providers/movie_provider.dart';
import 'package:movies/src/search/search_delegate.dart';

import 'package:movies/src/widgets/card_swiper_widget.dart';
import 'package:movies/src/widgets/horizontal_card.dart';

class HomePage extends StatelessWidget {
  final route = 'home/';

  final movieProvider = new MovieProvider();

  @override
  Widget build(BuildContext context) {
    movieProvider.getPopular();
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Películas en cines"),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: DataSearch(),
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
              _createCardSwiper(),
              SizedBox(height: 10.0),
              _createfooter(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createCardSwiper() {
    return FutureBuilder(
      future: movieProvider.getNowPlaying(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData)
          return CardSwiperWidget(movies: snapshot.data);
        else
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
      },
    );
  }

  Widget _createfooter(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Populares",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          StreamBuilder(
            stream: movieProvider.popularStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData)
                return HorizontalWidget(
                  movies: snapshot.data,
                  nextPage: movieProvider.getPopular,
                );
              else
                return Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
