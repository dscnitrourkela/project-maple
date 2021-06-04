import 'package:aptiche/utils/theme.dart';
import 'package:aptiche/utils/ui_scaling.dart';
import 'package:aptiche/views/login/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: kBgColour,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                Get.to<dynamic>(() => const LoginView());
              },
              child: const Text('Go Ahead')),
          SizedBox(
            child: Center(
              child: Text('APTICHE',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).primaryTextTheme.headline1),
            ),
          ),
        ],
      )),
    );
  }
}
