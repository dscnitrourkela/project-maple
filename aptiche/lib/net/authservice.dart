import 'package:aptiche/views/data%20entry/dataentry.dart';
import 'package:aptiche/views/login/logincontroller.dart';
import 'package:aptiche/views/login/loginscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthService extends GetxController {
  LoginController loginController = Get.find();

  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //TODO - get to Home Screen
          } else {
            Get.to(() => LoginView());
          }
          return CircularProgressIndicator();
        });
  }

  signOut() {
    FirebaseAuth.instance.signOut();
    //TODO - return to Login Screen
  }

  signIn(
    AuthCredential authCredential,
  ) async {
    FirebaseAuth.instance.signInWithCredential(authCredential).then((value) {
      //TODO - send JWT Tokens and FCM Token to Mongo

      if (value.user != null) {
        loginController.status.value = 'Authentication successful';
      } else {
        loginController.status.value = 'Invalid code/invalid authentication';
      }
    }).catchError((error) {
      loginController.status.value =
          'Something has gone wrong, please try later';
    });
  }

  signInwithOTP(
    String smsCode,
    String verId,
  ) {
    AuthCredential authCredential = PhoneAuthProvider.credential(
      verificationId: verId,
      smsCode: smsCode,
    );
    signIn(
      authCredential,
    );
  }
}
