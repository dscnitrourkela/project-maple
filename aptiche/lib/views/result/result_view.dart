import 'package:aptiche/utils/ui_scaling.dart';
import 'package:aptiche/views/home/homescreen.dart';
import 'package:aptiche/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResultView extends StatelessWidget {
  const ResultView({Key? key, required this.score, required this.totalScore})
      : super(key: key);
  final int score;
  final int totalScore;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.all(SizeConfig.safeBlockVertical!),
                    height: SizeConfig.screenWidth! * 0.7,
                    child: Image.asset('assets/images/result.png')),
                Container(
                  padding: EdgeInsets.all(SizeConfig.safeBlockVertical!),
                  child: Text(
                    'Hurray! You finished the quiz. Have a break!',
                    textAlign: TextAlign.center,
                    style:
                        Theme.of(context).primaryTextTheme.headline2!.copyWith(
                              fontSize: SizeConfig.screenWidth! * 0.07,
                            ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(SizeConfig.safeBlockVertical!),
                    child: Text(
                      '$score/$totalScore',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .primaryTextTheme
                          .headline2!
                          .copyWith(
                            fontSize: SizeConfig.screenWidth! * 0.1,
                            fontWeight: FontWeight.bold,
                          ),
                    )),
                CustomButton(
                    onTap: () {
                      Get.offAll<HomeScreen>(const HomeScreen());
                    },
                    verticalPadding: SizeConfig.safeBlockHorizontal!.toDouble(),
                    horizontalPadding: SizeConfig.safeBlockHorizontal!.abs(),
                    text: 'Back to Homescreen'),
              ]),
        ),
      ),
    );
  }
}
