import 'package:aptiche/net/authservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController {
  final formkey = new GlobalKey<FormState>();
  final phoneEditController = new TextEditingController();
  final AuthService _authService = Get.put(AuthService());

  final sent = false.obs;
  RxString status = ''.obs;

  var phoneNo = ''.obs;
  var verificationId = '';
  var smsCode = ''.obs;
  var codeSent = false.obs;
  var loading = false.obs;

  createUser() async {
    await _authService.signInwithOTP(
      this.smsCode.toString(),
      this.verificationId.toString(),
    );
  }

  Future<void> verifyPhone() async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      _authService.signIn(authResult);
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      debugPrint('${authException.message}');
      status.value = 'Something has gone wrong, please try later';
    };

    final PhoneCodeSent smsSent = (String verId, [int? forceResend]) async {
      this.codeSent = true.obs;
      this.loading = false.obs;
      debugPrint("code sent to " + phoneNo.toString());

      this.verificationId = verId;
    };
    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
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
