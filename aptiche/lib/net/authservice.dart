import 'package:aptiche/views/data%20entry/dataentry.dart';
import 'package:aptiche/views/home/homescreen.dart';
import 'package:aptiche/views/login/loginscreen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

  void signIn(AuthCredential authCredential, bool stat) async {
    FirebaseAuth.instance.signInWithCredential(authCredential).then((
      UserCredential value,
    ) {
      if (value.user != null) {
        stat = true;
      } else {
        stat = false;
      }
      Get.to<dynamic>(() => const DataEntryScreen());
    }).catchError((Error error) {
      debugPrint(error.toString());
      Get.snackbar<dynamic>(
        '',
        'Something went wrong. Please try again',
      );
      stat = false;
    });
  }

  void signInwithOTP(String smsCode, String verId, bool stat) {
    final AuthCredential authCredential = PhoneAuthProvider.credential(
      verificationId: verId,
      smsCode: smsCode,
    );
    /* if (authCredential.token == null) {
      Get.snackbar<dynamic>(
        '',
        'Something went wrong. Please try again',
      );
    } else { */
    print(authCredential.token.toString());
    signIn(authCredential, stat);

    //}
  }
}
