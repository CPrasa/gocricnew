import 'package:flutter/material.dart';
import 'package:gocric/News_page.dart';
import 'package:gocric/home_page.dart';
import 'package:gocric/src/features/authentication/controllers/authentication_repository.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.red,
      titleSpacing: 0.0,
      title: const Row(
        children: [
          // You can customize the contents of your AppBar as needed
          SizedBox(width: 8),
          Text(
            'GoCric',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.yellow,
              fontSize: 30,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.home,
            color: Colors.yellow,
            size: 30,
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
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => FavoritePage()),
            );
          },
        ),
        ElevatedButton.icon(
          onPressed: () {
            AuthenticationRepository.instance.logout();
          },
          icon: const Icon(
            Icons.logout,
            color: Colors.white,
          ),
          label: const Text(
            'Logout',
            style: TextStyle(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            elevation: 4,
          ),
        ),
      ],
    );
  }
}