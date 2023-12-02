import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocric/home_page.dart';
import 'package:gocric/src/features/authentication/controllers/signup_failure.dart';
import 'package:gocric/src/features/authentication/screens/welcome_screen.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const WelcomeScreen())
        : Get.offAll(() => const HomePage());
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      firebaseUser.value != null
          ? Get.offAll(() => const HomePage())
          : Get.to(() => const WelcomeScreen());
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      debugPrint('FIREBASE AUTH EXCEPTION - ${ex.message}');
      throw ex;
    } catch (_) {
      const ex = SignUpWithEmailAndPasswordFailure();
      debugPrint('EXCEPTION - ${ex.message}');
      throw ex;
    }
  }

  Future<void> loginWithEmailAddressAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
    } catch (_) {}
  }

  Future<void> logout() async => await _auth.signOut();
}
