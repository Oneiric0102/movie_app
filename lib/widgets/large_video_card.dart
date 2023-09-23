import 'package:flutter/material.dart';
import 'package:movie_app/screens/detail_screen.dart';

import '../services/api_service.dart';

class LargeVideoCard extends StatelessWidget {
  final String backdropPath;
  final int id;

  static get height => 250.0;

  const LargeVideoCard({
    super.key,
    required this.backdropPath,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(
                id: id,
              ),
            ),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.network(
            width: 300,
            height: 250,
            '${ApiService.imageBaseUrl}$backdropPath',
            fit: BoxFit.cover,
            headers: const {
              "User-Agent":
                  "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
            },
          ),
        ));
  }
}
