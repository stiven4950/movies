import 'package:flutter/material.dart';
import 'package:movies/src/providers/movie_provider.dart';

import 'package:movies/src/routes/routes.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MovieProvider(), lazy: false),
      ],
      child: MaterialApp(
        title: 'Películas',
        debugShowCheckedModeBanner: false,
        initialRoute: 'home/',
        routes: getApplicationRoutes,
        theme: ThemeData.light().copyWith(
          appBarTheme: AppBarTheme(
            color: Colors.indigo,
          ),
        ),
      ),
    );
  }
}
