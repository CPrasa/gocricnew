import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocric/firebase_options.dart';
import 'package:gocric/src/features/authentication/controllers/authentication_repository.dart';

import 'src/features/authentication/screens/welcome_screen.dart';
import 'src/theme/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightMode,
      home: const WelcomeScreen(),
    );
  }
}
//firebase connected branch 