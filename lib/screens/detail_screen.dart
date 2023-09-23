import 'package:flutter/material.dart';
import 'package:movie_app/models/video_detail_model.dart';
import 'package:movie_app/services/api_service.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatefulWidget {
  final int id;
  const DetailScreen({
    super.key,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<VideoDetailModel> video;
  late String posterPath;

  @override
  void initState() {
    super.initState();
    video = ApiService.getVideoDetailById(widget.id);
  }

  goHomepage(urlString) async {
    final url = Uri.parse(urlString);
    await launchUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: video,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: Image.network(
                      '${ApiService.imageBaseUrl}${snapshot.data!.posterPath}',
                    ).image,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.2),
                      Colors.black.withOpacity(0.5),
                    ],
                  ),
                ),
              ),
              Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  centerTitle: false,
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  title: const Text("Back to list"),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data!.title,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      starRate(snapshot.data!),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Text(
                            '${snapshot.data!.runtime ~/ 60}h ${snapshot.data!.runtime % 60}min | ${genersToString(snapshot.data!.genres)}',
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      const Text(
                        "Storyline",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        snapshot.data!.overview,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      GestureDetector(
                        onTap: () {
                          goHomepage(snapshot.data!.homepage);
                        },
                        child: Center(
                          child: Container(
                            width: 300,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.yellow,
                            ),
                            child: const Center(
                              child: Text(
                                "Go Homepage",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Row starRate(VideoDetailModel video) {
    double videoRate = video.voteAverage / 2;
    int i = 1;
    double starSize = 24.0;
    double opacity = 0.35;
    return Row(
      children: [
        for (i; i <= video.voteAverage / 2; i++)
          Icon(
            Icons.star_rate_rounded,
            size: starSize,
            color: Colors.yellow,
          ),
        ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              colors: [
                Colors.yellow,
                Colors.white.withOpacity(opacity),
              ],
              tileMode: TileMode.mirror,
              stops: [videoRate - i + 1, videoRate - i + 1],
            ).createShader(bounds);
          },
          child: Icon(
            Icons.star_rate_rounded,
            size: starSize,
            color: Colors.white,
          ),
        ),
        for (var j = i; j < 5; j++)
          Icon(
            Icons.star_rate_rounded,
            size: starSize,
            color: Colors.white.withOpacity(opacity),
          ),
      ],
    );
  }
}

String genersToString(List<dynamic> genres) {
  List<dynamic> genresName = genres.map((genre) => genre["name"]).toList();
  String result;
  if (genresName.length > 5) {
    result = genresName.sublist(0, 5).join(', ');
  } else {
    result = genresName.join(', ');
  }
  return result;
}
