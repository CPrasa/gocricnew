// favorite_page.dart

import 'package:flutter/material.dart';
import 'home_page.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.home, size: 30,
              color: Colors.black, // Set the color to black
            ),
            onPressed: () {
              // Navigate to the home page
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.favorite,
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
      body: Center(
        child: Text(
          'Favorites Page Content',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
