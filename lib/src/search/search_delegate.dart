import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/pages/movie_detail_page.dart';
import 'package:movies/src/providers/movie_provider.dart';

class DataSearch extends SearchDelegate {
  /* final movies = [
    'Spiderman',
    'Aquaman',
    'Batman',
    'Shazam',
    'Ironman',
    'Capitán América',
  ]; */

  final movieProvider = new MovieProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    // AppBar actions
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icon in left position
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // Create results to show
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) return Container();

    return FutureBuilder(
      future: movieProvider.getSearchingMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {
          final movies = snapshot.data;
          return ListView(
            children: movies.map((movie) {
              movie.uniqueId = "${movie.id}2";
              return ListTile(
                leading: Hero(
                  tag: movie.uniqueId,
                  child: FadeInImage(
                    placeholder: AssetImage('assets/image/no-image.jpg'),
                    image: NetworkImage(
                      movie.getPosterImage(),
                    ),
                    width: 50.0,
                    fit: BoxFit.contain,
                  ),
                ),
                title: Text(movie.title),
                subtitle: Text(movie.originalTitle),
                onTap: () {
                  close(context, null);
                  Navigator.pushNamed(
                    context,
                    MovieDetailPage().route,
                    arguments: movie,
                  );
                },
              );
            }).toList(),
          );
        } else
          return Center(
            child: CircularProgressIndicator(),
          );
      },
    );
  }

  /* @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? movies
        : movies
            .where((m) => m.toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    // Suggestions when user types
    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.movie),
            title: Text(suggestionList[index]),
          );
        });
  } */
}
