import 'package:aptiche/utils/theme.dart';
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
            return const HomeScreen();
          } else {
            return const LoginView();
          }
        });
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
    Get.to<dynamic>(const LoginView());
    // Get.to<dynamic>(() => const LoginView());
  }

  void signInwithOTP(String smsCode, String verId) async {
    try {
      final AuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: verId,
        smsCode: smsCode,
      );
      await FirebaseAuth.instance.signInWithCredential(authCredential);

      Get.to<dynamic>(() => const DataEntryScreen());
    } catch (error) {
      customSnackBar(
        'Authentication Error - WRONG OTP',
        'Please enter the correct OTP sent to your mobile number',
      );
    }
  }
}
