class VideoDetailModel {
  final String posterPath, title, overview, homepage;
  final int runtime, voteCount;
  final double voteAverage;
  final List<dynamic> genres;

  VideoDetailModel.fromJson(Map<String, dynamic> json)
      : posterPath = json["poster_path"],
        title = json["title"],
        overview = json["overview"],
        homepage = json["homepage"],
        runtime = json["runtime"],
        voteCount = json["vote_count"],
        voteAverage = json["vote_average"],
        genres = json["genres"];
}
