import 'package:aptiche/services/graphql.dart';
import 'package:aptiche/views/dataentry/dataentry.dart';
import 'package:aptiche/views/home/homescreen.dart';
import 'package:aptiche/views/login/logincontroller.dart';
import 'package:aptiche/views/login/loginscreen.dart';
import 'package:aptiche/views/splashscreen/splashscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthService extends GetxController {
  final GraphQLService _graphQL = Get.find();
  Future<Widget> handleAuth() async {
    if (FirebaseAuth.instance.currentUser == null)
      return const LoginView();
    else if (FirebaseAuth.instance.currentUser != null &&
        await _graphQL.checkUserbyPhone(
                phoneNo: FirebaseAuth.instance.currentUser!.phoneNumber) ==
            'null')
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
      await _graphQL.initGraphQL(getUserToken().toString());
      // print(await _graphQL.checkUserbyPhone(
      //     phoneNo: FirebaseAuth.instance.currentUser!.phoneNumber));
      if (await _graphQL.checkUserbyPhone(
              phoneNo: FirebaseAuth.instance.currentUser!.phoneNumber) ==
          'null') {
        await Get.off<dynamic>(() => const DataEntryScreen());
      } else {
        await Get.off<dynamic>(() => const SplashScreen());
      }
    } catch (error) {
      print(error);
      /* CustomLoaders().customSnackBar(
        'Authentication Error - WRONG OTP',
        'Please enter the correct OTP sent to your mobile number',
      ); */
    }
  }

  String getUserToken() {
    if (FirebaseAuth.instance.currentUser != null) {
      return FirebaseAuth.instance.currentUser!.getIdToken(true).toString();
    } else {
      return '';
    }
  }
}
