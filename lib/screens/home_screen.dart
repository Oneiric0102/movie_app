import 'package:flutter/material.dart';
import 'package:movie_app/models/video_model.dart';
import 'package:movie_app/services/api_service.dart';
import 'package:movie_app/widgets/large_video_card.dart';
import 'package:movie_app/widgets/small_video_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<VideoModel>> popularMovies = ApiService.getPopularMovies();
  final Future<List<VideoModel>> nowInCinemas =
      ApiService.getNowInCidemaMovies();
  final Future<List<VideoModel>> comingSoon = ApiService.getComingSoonMovies();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  child: Text(
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    ),
                    "Popular Movies",
                  ),
                ),
                FutureBuilder(
                  future: popularMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return makeLargeVideoCardsList(snapshot);
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  child: Text(
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    ),
                    "Now in Cinemas",
                  ),
                ),
                FutureBuilder(
                  future: nowInCinemas,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return makeSmallVideoCardsList(snapshot);
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  child: Text(
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    ),
                    "Coming soon",
                  ),
                ),
                FutureBuilder(
                  future: comingSoon,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return makeSmallVideoCardsList(snapshot);
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  SizedBox makeSmallVideoCardsList(AsyncSnapshot<List<VideoModel>> snapshot) {
    return SizedBox(
      height: SmallVideoCard.height,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          final video = snapshot.data![index];
          return SmallVideoCard(
            backdropPath: video.backdropPath,
            title: video.title,
            id: video.id,
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
          width: 15,
        ),
      ),
    );
  }

  SizedBox makeLargeVideoCardsList(AsyncSnapshot<List<VideoModel>> snapshot) {
    return SizedBox(
      height: LargeVideoCard.height,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          final video = snapshot.data![index];
          return LargeVideoCard(
            backdropPath: video.backdropPath,
            id: video.id,
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
          width: 15,
        ),
      ),
    );
  }
}
