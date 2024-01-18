import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../src/features/authentication/controllers/authentication_repository.dart';

class NavBar extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getAccountPicture(),
      builder: (context, snapshot) {
        return Drawer(
          backgroundColor: Colors.blue.shade100,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: const Text(
                  'Email Address',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.black),
                ),
                accountEmail: Text(
                  user.email!,
                  style: const TextStyle(backgroundColor: Colors.black),
                ),
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                    child: Image.network(
                      snapshot.data.toString(),
                      fit: BoxFit.cover,
                      width: 90,
                      height: 90,
                    ),
                  ),
                ),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        'https://t4.ftcdn.net/jpg/01/98/57/21/360_F_198572137_ZaaT2TEs02uOJMVdRLF9447bdjPeln8B.jpg'),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.share),
                title: const Text('Share'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Share'),
                        content: const Text(
                            'Implement your share functionality here.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Close'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.description),
                title: const Text('Policies'),
                onTap: () => null,
              ),
              ListTile(
                title: const Text('Log Out'),
                leading: const Icon(Icons.exit_to_app),
                onTap: () {
                  AuthenticationRepository.instance.logout();
                },
                splashColor: Colors.blue,
              ),
            ],
          ),
        );
      },
    );
  }

  Future<String> _getAccountPicture() async {
    final googleSignIn = GoogleSignIn();
    final googleSignInAccount = await googleSignIn.signInSilently();

    if (googleSignInAccount != null && googleSignInAccount.photoUrl != null) {
      // User has set a Google profile picture
      return googleSignInAccount.photoUrl!;
    } else {
      // Use the default picture
      return 'https://images.rawpixel.com/image_png_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIzLTAxL3JtNjA5LXNvbGlkaWNvbi13LTAwMi1wLnBuZw.png';
    }
  }
}
