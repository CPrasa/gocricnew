import 'package:flutter/material.dart';
import 'package:gocric/news_page.dart';
import 'package:gocric/home_page.dart';
import 'package:gocric/src/features/authentication/controllers/authentication_repository.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.deepPurple.shade200,
      titleSpacing: 0.0,
      title: const Row(
        children: [
          // You can customize the contents of your AppBar as needed
          SizedBox(width: 8),
          Text(
            'GoCric',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
              fontSize: 30,
            ),
          ),
        ],
      ),
    );
  }
}
