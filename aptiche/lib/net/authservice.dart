import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthService extends GetxController {
  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //TODO - get to Home Screen
          } else {
            //TODO - LoginScreen();
          }
        });
  }

  signOut() {
    FirebaseAuth.instance.signOut();
    //TODO - return to Login Screen
  }

  signInSeller(
    AuthCredential authCredential,
  ) async {
    FirebaseAuth.instance.signInWithCredential(authCredential).then((value) {
      //TODO - send JWT Tokens and FCM Token to Mongo
      //TODO - get to data entry screen
    });
  }

  signInwithOTPSeller(
    String smsCode,
    String verId,
  ) {
    AuthCredential authCredential = PhoneAuthProvider.credential(
      verificationId: verId,
      smsCode: smsCode,
    );
    signInSeller(
      authCredential,
    );
  }
}
