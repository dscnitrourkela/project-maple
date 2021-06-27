import 'package:aptiche/utils/theme.dart';
import 'package:aptiche/views/data%20entry/dataentry.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthService extends GetxController {
  String? handleAuth() {
    String? route;
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null)
        route = '/login';
      else
        route = '/home';
    }, onError: () {
      route = '/login';
    });
    return route;
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
    Get.offAllNamed<dynamic>('/splash');
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
      customSnackBar(
        'Authentication Error - WRONG OTP',
        'Please enter the correct OTP sent to your mobile number',
      );
    }
  }
}
