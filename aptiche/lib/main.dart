import 'package:aptiche/utils/bindings.dart';
import 'package:aptiche/utils/theme.dart';
import 'package:aptiche/views/splashscreen/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  HomeBinding().dependencies();
  await GetStorage().initStorage;
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
        future: _initialization,
        builder: (BuildContext context, AsyncSnapshot<FirebaseApp> snapshot) {
          if (snapshot.hasError) {
            return const CircularProgressIndicator();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return GetMaterialApp(
              title: 'APTI-CHE',
              debugShowCheckedModeBanner: false,
              theme: appTheme(),
              enableLog: true,
              defaultTransition: Transition.rightToLeftWithFade,
              popGesture: Get.isPopGestureEnable,
              home: const SplashScreen(),
            );
          }
          return Container();
        });
  }
}
