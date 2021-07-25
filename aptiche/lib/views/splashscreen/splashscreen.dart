import 'package:aptiche/services/graphql.dart';
import 'package:aptiche/services/net/authservice.dart';
import 'package:aptiche/utils/theme.dart';
import 'package:aptiche/utils/ui_scaling.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final GraphQLService _graphQLService = Get.find();
  final AuthService _authService = Get.find();

  @override
  Widget build(BuildContext context) {
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
                await GetStorage().initStorage;
                if (FirebaseAuth.instance.currentUser != null) {
                  _graphQLService
                      .initGraphQL(await _authService.getUserToken());
                }
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
