import 'package:aptiche/utils/theme.dart';
import 'package:aptiche/utils/ui_scaling.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GetMaterialApp(
      title: "APTI-CHE",
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      enableLog: true,
      defaultTransition: Transition.rightToLeftWithFade,
      popGesture: Get.isPopGestureEnable,
      //initialRoute:
      //routes:
    );
  }
}
