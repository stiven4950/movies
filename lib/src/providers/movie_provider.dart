import 'dart:async';
import 'dart:convert';

import 'package:movies/src/models/actor_model.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MovieProvider {
  String _apiKey = 'a96ff02ef30faf77d09332af7067abc0';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularPage = 0;
  bool _loading = false;

  List<Movie> _popular = new List.empty(growable: true);

  final _popularStreamController = StreamController<List<Movie>>.broadcast();

  //We must define two methods one to insert infromation to Stream,
  // Other for listen all that STream broadcast

  Function(List<Movie>) get popularSink => _popularStreamController.sink.add;

  Stream<List<Movie>> get popularStream => _popularStreamController.stream;

  void disposeStream() {
    _popularStreamController?.close();
  }

  Future<List<Movie>> getPopular() async {
    if (_loading) return [];
    _loading = true;

    _popularPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularPage.toString(),
    });

    final response = await _responseHttp(url);

    _popular.addAll(response);
    popularSink(_popular);

    _loading = false;

    return response;
  }

  Future<List<Movie>> _responseHttp(Uri url) async {
    final response = await http.get(url);

    final decodedData = json.decode(response.body);

    final movies = new Movies.fromJsonList(decodedData['results']);

    return movies.items;
  }

  Future<List<Movie>> getNowPlaying() async {
    _popularPage++;

    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
    });

    final response = await _responseHttp(url);

    return response;
  }

  Future<List<Actor>> getActor(String movieId) async {
    final url = Uri.https(_url, '3/movie/$movieId/credits', {
      'api_key': _apiKey,
      'language': _language,
    });

    final response = await http.get(url);

    final decodedData = json.decode(response.body);

    final actor = new Actors.fromJsonList(decodedData['cast']);

    return actor.items;
  }

  Future<List<Movie>> getSearchingMovie(String query) async {
    _popularPage++;

    final url = Uri.https(_url, '3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'query': query,
    });

    final response = await _responseHttp(url);

    return response;
  }
}
