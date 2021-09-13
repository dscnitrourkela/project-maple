import 'package:aptiche/utils/bindings.dart';
import 'package:aptiche/utils/theme.dart';
import 'package:aptiche/views/splashscreen/splashscreen.dart';
import 'package:aptiche/widgets/snackbar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HomeBinding().dependencies();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Future<void> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: _initialization,
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.hasError) {
            return CustomLoaders().customSnackBar(
              snapshot.error.toString(),
              'Could not load the application',
            );
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
          return const CircularProgressIndicator();
        });
  }
}
