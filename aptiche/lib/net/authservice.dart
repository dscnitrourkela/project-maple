import 'package:aptiche/views/home/homescreen.dart';
import 'package:aptiche/views/login/loginscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthService extends GetxController {
  bool status = false;

  Widget handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen();
          } else {
            return LoginView();
          }
        });
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
    //TODO - return to Login Screen
  }

  signIn(
    AuthCredential authCredential,
  ) async {
    FirebaseAuth.instance.signInWithCredential(authCredential).then((value) {
      //TODO - send JWT Tokens and FCM Token to Mongo

      if (value.user != null) {
        status = true;
      } else {
        status = false;
      }
    }).catchError((error) {
      status = false;
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
