import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/pages/movie_detail_page.dart';

class HorizontalWidget extends StatelessWidget {
  final List<Movie> movies;
  final Function nextPage;

  HorizontalWidget({@required this.movies, @required this.nextPage});

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        nextPage();
      }
    });

    return Container(
      height: _screenSize.height * 0.25,
      child: PageView.builder(
        itemCount: movies.length,
        pageSnapping: false,
        controller: _pageController,
        itemBuilder: (context, index) => _createCard(context, movies[index]),
      ),
    );
  }

  Widget _createCard(BuildContext context, Movie movie) {
    movie.uniqueId = "${movie.id}1";
    final itemCard = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          Hero(
            tag: movie.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/image/no-image.jpg'),
                image: NetworkImage(
                  movie.getPosterImage(),
                ),
                fit: BoxFit.cover,
                height: 140.0,
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );

    return GestureDetector(
      child: itemCard,
      onTap: () {
        Navigator.pushNamed(context, MovieDetailPage().route, arguments: movie);
      },
    );
  }
}
