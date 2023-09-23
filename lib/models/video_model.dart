class VideoModel {
  final int id;
  final String backdropPath, title;

  VideoModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        backdropPath = json["backdrop_path"],
        title = json["title"];
}
