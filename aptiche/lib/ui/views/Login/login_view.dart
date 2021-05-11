import 'package:aptiche/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 30.0,
            ),
            Center(
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: SvgPicture.asset(
                  loginScreenSVG,
                  alignment: Alignment.center,
                  height: 230.0,
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 30.0),
              alignment: Alignment.centerLeft,
              child: Text(
                'Hey, Welcome Back!',
                style: Theme.of(context).primaryTextTheme.headline1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
