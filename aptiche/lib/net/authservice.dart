import 'package:aptiche/views/home/homescreen.dart';
import 'package:aptiche/views/login/loginscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthService extends GetxController {
  bool status = false;

  StreamBuilder<User?> handleAuth() {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (
          BuildContext context,
          AsyncSnapshot<User?> snapshot,
        ) {
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

  void signIn(
    AuthCredential authCredential,
  ) async {
    FirebaseAuth.instance.signInWithCredential(authCredential).then((
      UserCredential value,
    ) {
      if (value.user != null) {
        status = true;
      } else {
        status = false;
      }
    }).catchError((dynamic error) {
      status = false;
    });
  }

  void signInwithOTP(
    String smsCode,
    String verId,
  ) {
    final AuthCredential authCredential = PhoneAuthProvider.credential(
      verificationId: verId,
      smsCode: smsCode,
    );
    signIn(
      authCredential,
    );
  }
}
