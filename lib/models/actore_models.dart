class Cast {
  List<Actor> actores = [];

  Cast.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var element in jsonList) {
      final actor = Actor.fromJsonMap(element);
      actores.add(actor);
    }
  }
}

class Actor {
  dynamic name;
  dynamic profilePath;
  

  Actor({
    required this.name,
    required this.profilePath,
    
  });

  Actor.fromJsonMap(Map<String, dynamic> json) {
    name = json['name'];
    profilePath = json['profile_path'];
    
  }
  getFoto() {
    if (profilePath == null) {
      return 'https://media.istockphoto.com/id/1288129985/vector/missing-image-of-a-person-placeholder.jpg?s=612x612&w=0&k=20&c=9kE777krx5mrFHsxx02v60ideRWvIgI1RWzR1X4MG2Y=';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }
}
