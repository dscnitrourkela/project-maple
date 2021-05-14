import 'package:aptiche/utils/theme.dart';
import 'package:aptiche/views/login/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "APTI-CHE",
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      enableLog: true,
      defaultTransition: Transition.rightToLeftWithFade,
      popGesture: Get.isPopGestureEnable,
      home: LoginView(),
    );
  }
}
