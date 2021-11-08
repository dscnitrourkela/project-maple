import 'package:aptiche/services/graphql.dart';
import 'package:aptiche/views/login/logincontroller.dart';
import 'package:aptiche/views/login/loginscreen.dart';
import 'package:aptiche/views/splashscreen/splashscreen.dart';
import 'package:aptiche/views/splashscreen/usercheck.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthService extends GetxController {
  final GraphQLService _graphQL = Get.find();
  Future<Widget> handleAuth() async {
    if (FirebaseAuth.instance.currentUser != null) {
      final String token = await getUserToken();
      await _graphQL.initGraphQL(token);
      return UserCheck();
    } else
      return const LoginView();
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
      await Get.off<UserCheck>(() => UserCheck());
    } catch (error) {
      debugPrint(error.toString());
      /* CustomLoaders().customSnackBar(
        'Authentication Error - WRONG OTP',
        'Please enter the correct OTP sent to your mobile number',
      ); */
    }
  }

  String? getCurrentUserPhone() {
    return FirebaseAuth.instance.currentUser != null
        ? FirebaseAuth.instance.currentUser?.phoneNumber
        : '';
  }

  Future<String> getUserToken() async {
    if (FirebaseAuth.instance.currentUser != null) {
      final String token =
          await FirebaseAuth.instance.currentUser!.getIdToken();
      return token;
    } else {
      return '';
    }
  }
}
