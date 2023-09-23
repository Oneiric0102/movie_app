import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/models/video_detail_model.dart';
import 'package:movie_app/models/video_model.dart';

class ApiService {
  static const String baseUrl = "https://movies-api.nomadcoders.workers.dev/";
  static const String imageBaseUrl = "https://image.tmdb.org/t/p/w500";
  static const String popular = 'popular';
  static const String nowInCinemas = 'now-playing';
  static const String comingSoon = 'coming-soon';
  static const String toGetDetail = 'movie?id=';

  static Future<List<VideoModel>> getPopularMovies() async {
    List<VideoModel> popularMovieInstances = [];
    final url = Uri.parse('$baseUrl$popular');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var videos = jsonDecode(response.body)["results"];
      for (var video in videos) {
        popularMovieInstances.add(VideoModel.fromJson(video));
      }
      return popularMovieInstances;
    }
    throw Error();
  }

  static Future<List<VideoModel>> getNowInCidemaMovies() async {
    List<VideoModel> popularMovieInstances = [];
    final url = Uri.parse('$baseUrl$nowInCinemas');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var videos = jsonDecode(response.body)["results"];
      for (var video in videos) {
        popularMovieInstances.add(VideoModel.fromJson(video));
      }
      return popularMovieInstances;
    }
    throw Error();
  }

  static Future<List<VideoModel>> getComingSoonMovies() async {
    List<VideoModel> popularMovieInstances = [];
    final url = Uri.parse('$baseUrl$comingSoon');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var videos = jsonDecode(response.body)["results"];
      for (var video in videos) {
        popularMovieInstances.add(VideoModel.fromJson(video));
      }
      return popularMovieInstances;
    }
    throw Error();
  }

  static Future<VideoDetailModel> getVideoDetailById(int id) async {
    final url = Uri.parse('$baseUrl$toGetDetail$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final video = jsonDecode(response.body);
      return VideoDetailModel.fromJson(video);
    }
    throw Error();
  }
}
