import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  final String headline;
  final String introduction;
  final String publicationTime;

  NewsCard({
    required this.headline,
    required this.introduction,
    required this.publicationTime,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.shade400,
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              headline,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              introduction,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Text(
              'Published on: $publicationTime',
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
