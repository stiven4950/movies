import 'package:flutter/material.dart';
import 'package:movies/src/models/actor_model.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/providers/movie_provider.dart';

class MovieDetailPage extends StatelessWidget {
  final route = 'moviedetail/';
  const MovieDetailPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _createAppBar(movie),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10.0),
                _createPosterTitle(context, movie),
                _createDescription(movie),
                _createActorDetail(context, movie),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _createAppBar(Movie movie) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movie.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          image: NetworkImage(movie.getBackgroundImage()),
          placeholder: AssetImage('assets/image/loading.gif'),
          //fadeInDuration: Duration(microseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _createPosterTitle(BuildContext context, Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Hero(
            tag: movie.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(movie.getPosterImage()),
                height: 150.0,
              ),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: Theme.of(context).textTheme.headline5,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  movie.originalTitle,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Icon(Icons.star_border),
                    Text(
                      movie.voteAverage.toString(),
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _createDescription(Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _createActorDetail(BuildContext context, Movie movie) {
    final movieProvider = new MovieProvider();

    return FutureBuilder(
      future: movieProvider.getActor(movie.id.toString()),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return _createActorPageView(snapshot.data);
        } else
          return Center(
            child: CircularProgressIndicator(),
          );
      },
    );
  }

  Widget _createActorPageView(List<Actor> actor) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
          pageSnapping: false,
          controller: PageController(
            viewportFraction: 0.3,
            initialPage: 1,
          ),
          itemCount: actor.length,
          itemBuilder: (context, index) {
            return _createActorCard(context, actor[index]);
          }),
    );
  }

  Widget _createActorCard(BuildContext context, Actor actor) {
    return Container(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(actor.getPick()),
              height: 150.0,
              placeholder: AssetImage('assets/image/no-image.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            actor.name,
            style: Theme.of(context).textTheme.caption,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
