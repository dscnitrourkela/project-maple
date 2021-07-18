import 'package:aptiche/services/graphql.dart';
import 'package:aptiche/services/net/authservice.dart';
import 'package:aptiche/utils/theme.dart';
import 'package:aptiche/utils/ui_scaling.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aptiche/datamodels/user.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final AuthService _authService = Get.find();
  final GraphQL _graphQL = Get.find();
  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.instance.onTokenRefresh.listen(
      (String event) {
        setFCMToken(event);
      },
    );
    final AnimationController animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: kBgColour,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Lottie.asset('assets/animation/fakesplash.json',
              controller: animationController,
              onLoaded: (LottieComposition composition) {
            animationController
                .addStatusListener((AnimationStatus status) async {
              final StreamBuilder<User?> route = _authService.handleAuth();
              if (status == AnimationStatus.completed) {
                await _graphQL.initGraphQL();
                Get.to<dynamic>(() => route);
              }
            });
            animationController
              ..duration = composition.duration
              ..forward();
          }),
        ],
      )),
    );
  }
}
