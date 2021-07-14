import 'package:flutter/material.dart';
import 'package:movies/src/pages/home_page.dart';
import 'package:movies/src/pages/movie_detail_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes = {
  HomePage.route: (context) => HomePage(),
  MovieDetailPage.route: (context) => MovieDetailPage(),
};
