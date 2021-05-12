import 'package:aptiche/net/authservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController {
  final formkey = new GlobalKey<FormState>();
  final phoneEditController = new TextEditingController();

  var phoneNo = ''.obs;
  var verificationId = ''.obs;
  var smsCode = ''.obs;
  var codeSent = false.obs;
  var loading = false.obs;

  createUser() async {
    await AuthService().signInwithOTPSeller(
      this.smsCode.toString(),
      this.verificationId.toString(),
    );
  }

  Future<void> verifyPhone() async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signInSeller(authResult);
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      debugPrint('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) async {
      this.codeSent = true.obs;
      this.loading = false.obs;
      debugPrint("code sent to " + phoneNo.toString());
      this.verificationId = verId.obs;
    };
    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId.obs;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNo.toString(),
      timeout: const Duration(seconds: 60),
      verificationCompleted: verified,
      verificationFailed: verificationFailed,
      codeSent: smsSent,
      codeAutoRetrievalTimeout: autoTimeout,
    );
  }
}
