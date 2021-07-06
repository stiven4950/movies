import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/pages/movie_detail_page.dart';

class CardSwiperWidget extends StatelessWidget {
  final List<Movie> movies;

  CardSwiperWidget({@required this.movies});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return _createCardSwiper(context, movies[index]);
        },
        itemCount: movies.length,
        itemWidth: _screenSize.width * 0.7,
        //pagination: new SwiperPagination(),
        //control: new SwiperControl(),
        layout: SwiperLayout.STACK,
        itemHeight: _screenSize.height * 0.5,
      ),
    );
  }

  Widget _createCardSwiper(BuildContext context, Movie movie) {
    movie.uniqueId = "${movie.id}0";
    final cardSwiper = new Hero(
      tag: movie.uniqueId,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: FadeInImage(
          image: NetworkImage(movie.getPosterImage()),
          placeholder: ExactAssetImage('assets/image/no-image.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, MovieDetailPage().route,
          arguments: movie),
      child: cardSwiper,
    );
  }
}
