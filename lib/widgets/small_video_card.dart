import 'package:flutter/material.dart';

import '../screens/detail_screen.dart';
import '../services/api_service.dart';

class SmallVideoCard extends StatelessWidget {
  final String backdropPath, title;
  final int id;

  static get height => 240.0;

  const SmallVideoCard({
    super.key,
    required this.backdropPath,
    required this.id,
    required this.title,
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
        child: SizedBox(
          width: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  height: 160,
                  '${ApiService.imageBaseUrl}$backdropPath',
                  fit: BoxFit.cover,
                  headers: const {
                    "User-Agent":
                        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                title,
              )
            ],
          ),
        ));
  }
}
