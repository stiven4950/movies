class Movies {
  List<Movie> items = new List.empty(growable: true);

  Movies();

  Movies.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final movie = new Movie.fromJsonMap(item);
      items.add(movie);
    }
  }
}

class Movie {
  String uniqueId;
  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;

  Movie({
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.id,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });

  Movie.fromJsonMap(Map<String, dynamic> json) {
    popularity = json['popularity'] / 1;
    voteCount = json['vote_count'];
    video = json['video'];
    posterPath = json['poster_path'];
    id = json['id'];
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    genreIds = json['genre_ids'].cast<int>();
    title = json['title'];
    voteAverage = json['vote_average'] / 1;
    overview = json['overview'];
    releaseDate = json['release_date'];
  }

  getPosterImage() {
    if (posterPath == null)
      return 'https://cdn11.bigcommerce.com/s-hcp6qon/stencil/b01010e0-8f17-0138-8846-0242ac110011/icons/icon-no-image.svg';
    else
      return 'https://image.tmdb.org/t/p/w500/$posterPath';
  }

  String getBackgroundImage() {
    if (backdropPath == null)
      return 'https://cdn11.bigcommerce.com/s-hcp6qon/stencil/b01010e0-8f17-0138-8846-0242ac110011/icons/icon-no-image.svg';
    else
      return 'https://image.tmdb.org/t/p/w500$backdropPath';
  }
}
