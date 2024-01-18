import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocric/src/features/authentication/controllers/authentication_repository.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
  }

  void registerUser(String email, String password) async {
    var result = await AuthenticationRepository.instance
        .createUserWithEmailAndPassword(email, password);

    if (result is String) {
      Get.showSnackbar(GetSnackBar(
        message: result.toString(),
      ));
    } else if (result is Exception) {
      Get.showSnackbar(GetSnackBar(
        message: result.toString(),
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
