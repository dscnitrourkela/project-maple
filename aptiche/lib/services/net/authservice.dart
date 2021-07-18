import 'package:aptiche/services/graphql.dart';
import 'package:aptiche/utils/theme.dart';
import 'package:aptiche/views/data%20entry/dataentry.dart';
import 'package:aptiche/views/home/homescreen.dart';
import 'package:aptiche/views/login/loginscreen.dart';
import 'package:aptiche/views/splashscreen/splashscreen.dart';
import 'package:aptiche/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthService extends GetxController {
  GraphQL graphQL = Get.find();
  StreamBuilder<User?> handleAuth() {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<Object?> snapshot) {
          if (snapshot.hasError) {
            return const LoginView();
          } else {
            if (snapshot.hasData) {
              return HomeScreen();
            } else {
              return const LoginView();
            }
          }
        });
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
    Get.offAll<dynamic>(const SplashScreen());
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
      CustomLoaders().customSnackBar(
        'Authentication Error - WRONG OTP',
        'Please enter the correct OTP sent to your mobile number',
      );
    }
  }

  Future<String> getUserToken() async {
    return FirebaseAuth.instance.currentUser!.getIdToken(true);
  }

  Future<void> getUsers() async {
    await graphQL.getUser();
  }
}
