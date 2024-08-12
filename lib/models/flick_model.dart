class FlickModel {
  final String poster_path, title;
  final int id;

  FlickModel(Map<String, dynamic> json)
      : poster_path = json['poster_path'],
        title = json['title'],
        id = json['id'];
}
