import 'package:aptiche/utils/ui_scaling.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(SizeConfig.safeBlockVertical!),
                height: SizeConfig.screenWidth! * 0.8,
                child: Image.asset('assets/images/404.png')),
            //text showing no internet connection
            Text(
              'I am sorry, we are unable to connect to the internet',
              style: TextStyle(
                  fontFamily: 'SFPro',
                  fontSize: SizeConfig.safeBlockHorizontal! * 5,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
