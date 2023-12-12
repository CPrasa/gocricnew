// favorite_page.dart
import 'package:flutter/material.dart';
import 'package:gocric/Widget/newscard.dart';
import 'home_page.dart';
// Import the new NewsCard widget

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
        title: const Text(
          'News',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.yellow,
            fontSize: 30,
          ),
        ),
=======
        title: const Text('Favorites'),
>>>>>>> new_login
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.home,
              size: 30,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.newspaper_rounded,
              size: 30,
              color: Colors.yellow,
            ),
            onPressed: () {
              // Add your favorite logic here
              // ...
            },
          ),
        ],
      ),
<<<<<<< HEAD
      body: ListView(
        children: [
          NewsCard(
            headline: 'Exciting Cricket Match Today!',
            introduction:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
            publicationTime: '2023-12-12 14:30',
          ),
          // Add more news cards as needed
        ],
=======
      body: const Center(
        child: Text(
          'Favorites Page Content',
          style: TextStyle(fontSize: 20),
        ),
>>>>>>> new_login
      ),
    );
  }
}
