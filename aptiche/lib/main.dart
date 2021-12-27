import 'package:aptiche/services/theme_service.dart';
import 'package:aptiche/utils/bindings.dart';
import 'package:aptiche/utils/theme.dart';
import 'package:aptiche/views/result/error404.dart';
import 'package:aptiche/views/splashscreen/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HomeBinding().dependencies();
  await Firebase.initializeApp();
  await GetStorage.init();
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
          if (snapshot.hasError ||
              snapshot.connectionState == ConnectionState.none) {
            return const ErrorPage();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return GetMaterialApp(
              builder: (BuildContext context, Widget? child) {
                return ScrollConfiguration(
                    behavior: MyBehavior(), child: child!);
              },
              title: 'APTI-CHE',
              debugShowCheckedModeBanner: false,
              themeMode: Get.find<ThemeService>().theme,
              theme: AppThemes.lightThemeData,
              darkTheme: AppThemes.darkThemeData,
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

// Custom scroll Behavior to remove scroll glow
class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
