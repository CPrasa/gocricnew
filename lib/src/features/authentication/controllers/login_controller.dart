import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocric/src/features/authentication/controllers/authentication_repository.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();

  Future<void> login() async {
    String? error = await AuthenticationRepository.instance
        .loginWithEmailAndPassword(email.text.trim(), password.text.trim());
    if (error != null) {
      Get.showSnackbar(GetSnackBar(
        message: error.toString(),
      ));
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      await AuthenticationRepository.instance.signInWithGoogle();
    } catch (e) {
      // Handle Google Sign In errors, if any.
      print("Error signing in with Google: $e");
    }
  }
}
