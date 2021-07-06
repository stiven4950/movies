class Actors {
  List<Actor> items = new List.empty();

  Actors();

  Actors.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    jsonList.forEach((element) {
      final actor = new Actor.fromJsonMap(element);
      items.add(actor);
    });
  }
}

class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  Actor.fromJsonMap(Map<String, dynamic> json) {
    castId = json['cast_id'];
    character = json['character'];
    creditId = json['credit_id'];
    gender = json['gender'];
    id = json['id'];
    name = json['name'];
    order = json['order'];
    profilePath = json['profile_path'];
  }

  getPick() {
    if (profilePath == null)
      return 'https://www.kindpng.com/picc/m/22-223863_no-avatar-png-circle-transparent-png.png';
    else
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
  }
}
