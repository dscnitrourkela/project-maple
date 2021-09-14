import 'package:aptiche/views/dataentry/dataentry.dart';
import 'package:aptiche/views/home/homescreen.dart';
import 'package:aptiche/views/login/logincontroller.dart';
import 'package:aptiche/views/login/loginscreen.dart';
import 'package:aptiche/views/splashscreen/splashscreen.dart';
import 'package:aptiche/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthService extends GetxController {
  Widget handleAuth() {
    if (FirebaseAuth.instance.currentUser == null)
      return const LoginView();
    else if (FirebaseAuth.instance.currentUser != null &&
        FirebaseAuth.instance.currentUser!.phoneNumber != null)
      return const DataEntryScreen();
    else
      return const HomeScreen();
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
    GetStorage('User').erase();
    LoginController().codeSent.value = false;
    Get.offAll<SplashScreen>(() => const SplashScreen());
  }

  Future<void> signInwithOTP(String smsCode, String verId) async {
    try {
      final AuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: verId,
        smsCode: smsCode,
      );
      await FirebaseAuth.instance.signInWithCredential(authCredential);

      await Get.to<DataEntryScreen>(() => const DataEntryScreen());
    } catch (error) {
      CustomLoaders().customSnackBar(
        'Authentication Error - WRONG OTP',
        'Please enter the correct OTP sent to your mobile number',
      );
    }
  }

  Future<String?> getUserToken() async {
    if (FirebaseAuth.instance.currentUser != null) {
      // ignore: unnecessary_await_in_return
      return await FirebaseAuth.instance.currentUser!.getIdToken(true);
    } else {
      return Future<String>.value('');
    }
  }
}
