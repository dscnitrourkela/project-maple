import 'package:aptiche/utils/ui_scaling.dart';
import 'package:aptiche/widgets/buttons.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    //Move it to Splash Screen
    SizeConfig().init(context);
    return Scaffold(
      body: Center(
          child: button("LOGIN", () {
        //TODO call authservice.signin
        //TODO send to data entry screen
      })),
    );
  }
}
