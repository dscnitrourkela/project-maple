import 'package:aptiche/services/graphql.dart';
import 'package:aptiche/services/net/authservice.dart';
import 'package:aptiche/utils/theme.dart';
import 'package:aptiche/utils/ui_scaling.dart';
import 'package:aptiche/views/result/error404.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
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
              Widget route;
              final ConnectivityResult connectivityResult =
                  await Connectivity().checkConnectivity();
              if (connectivityResult == ConnectivityResult.none &&
                  status == AnimationStatus.completed) {
                route = const ErrorPage();
              } else if (connectivityResult != ConnectivityResult.none &&
                  status == AnimationStatus.completed) {
                await GetStorage().initStorage;
                route = await _authService.handleAuth();
                if (FirebaseAuth.instance.currentUser != null) {
                  await _graphQLService
                      .initGraphQL(await _authService.getUserToken());
                }
              } else {
                route = const ErrorPage();
              }

              await Get.to<dynamic>(
                () => route,
              );
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
