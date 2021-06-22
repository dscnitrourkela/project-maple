import 'package:aptiche/net/authservice.dart';
import 'package:aptiche/utils/theme.dart';
import 'package:aptiche/views/data%20entry/dataentry.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final AuthService _authService = Get.find();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController phoneEditController = TextEditingController();
  final RxBool sent = false.obs;
  RxBool status = false.obs;
  RxString phoneNo = ''.obs;
  String verificationId = '';
  RxString smsCode = ''.obs;
  RxBool codeSent = false.obs;
  RxBool loading = false.obs;

  void createUser() {
    _authService.signInwithOTP(
      smsCode.toString(),
      verificationId.toString(),
    );
  }

  Future<void> verifyPhone() async {
    final PhoneVerificationCompleted verified =
        (AuthCredential authResult) async {
      await FirebaseAuth.instance.signInWithCredential(authResult);
      Get.to<dynamic>(() => const DataEntryScreen());
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      customSnackBar('Authentication Error - WRONG MOBILE NUMBER',
          authException.message.toString());
      status.value = false;
    };

    final PhoneCodeSent smsSent = (String verId, [int? forceResend]) async {
      codeSent.value = true;
      loading.value = false;
      debugPrint('code sent to $phoneNo');
      verificationId = verId;
    };
    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      verificationId = verId;
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
