import 'package:aptiche/views/data%20entry/dataentry.dart';
import 'package:aptiche/views/home/homescreen.dart';
import 'package:aptiche/views/login/loginscreen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AuthService extends GetxController {
  StreamBuilder<User?> handleAuth() {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (
          BuildContext context,
          AsyncSnapshot<User?> snapshot,
        ) {
          if (snapshot.hasData) {
            return const HomeScreen(
              name: 'logged in',
            );
          } else {
            return const LoginView();
          }
        });
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
    Get.offAll<dynamic>(() => const LoginView());
  }

  void signIn(AuthCredential authCredential) async {
    try {
      print('a1');
      final dynamic userCredential =
          (await FirebaseAuth.instance.signInWithCredential(authCredential))
              .user;
      print('a2');
      // Get.to<dynamic>(() => const DataEntryScreen());
      /*  if (FirebaseAuth.instance.currentUser == null) {
        Get.snackbar<dynamic>(
          '',
          'Something went wrong. Please try again',
        );
      } else {
        Get.to<dynamic>(() => const DataEntryScreen());
      } */
    } on PlatformException catch (e) {
      print(e.toString());
      print('a3');
      Get.snackbar<dynamic>(
        '',
        'Something went wrong. Please try again',
      );
    }
  }

  void signInwithOTP(String smsCode, String verId) {
    try {
      print('b1');
      final AuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: verId,
        smsCode: smsCode,
      );
      signIn(authCredential);
      print('b2');
    } catch (e) {
      print('b3');
      print(e);
    }
  }
}
