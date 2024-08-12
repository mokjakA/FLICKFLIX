class DetailModel {
  final String title;
  final String overview;
  final double vote_average;
  final List<String> genres;

  DetailModel(Map<String, dynamic> json)
      : title = json['original_title'],
        overview = json['overview'],
        vote_average = json['vote_average'],
        genres = (json['genres'] as List<dynamic>)
            .map((genre) => genre['name'] as String)
            .toList();
}
