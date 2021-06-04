import 'package:aptiche/net/authservice.dart';
import 'package:aptiche/utils/bindings.dart';
import 'package:aptiche/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  HomeBinding().dependencies();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final AuthService _authService = Get.find();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return CircularProgressIndicator();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return GetMaterialApp(
              title: "APTI-CHE",
              debugShowCheckedModeBanner: false,
              theme: appTheme(),
              enableLog: true,
              defaultTransition: Transition.rightToLeftWithFade,
              popGesture: Get.isPopGestureEnable,
              home: _authService.handleAuth(),
            );
          }
          return Container();
        });
  }
}
