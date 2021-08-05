import 'package:aptiche/datamodels/api_models.dart';
import 'package:aptiche/utils/date_time.dart';
import 'package:aptiche/utils/string.dart';
import 'package:aptiche/utils/theme.dart';
import 'package:aptiche/utils/ui_scaling.dart';
import 'package:aptiche/views/testpreview/test_preview_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeGridTile extends StatelessWidget {
  const HomeGridTile({
    Key? key,
    required this.quiz,
  }) : super(key: key);

  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to<TestPreviewView>(
        TestPreviewView(
          quiz: quiz,
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: SizeConfig.screenWidth! * 0.04,
          vertical: SizeConfig.screenWidth! * 0.04,
        ),
        decoration: BoxDecoration(
          color: kGreyBgColor,
          borderRadius: BorderRadius.circular(20.0),
        ),
        height: SizeConfig.screenWidth! * 0.45,
        width: SizeConfig.screenWidth! * 0.45,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: SizeConfig.safeBlockVertical,
            ),
            Image.asset(
              Strings.quizPNG,
              width: SizeConfig.safeBlockHorizontal! * 20,
              height: SizeConfig.safeBlockVertical! * 10,
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical,
            ),
            Text(
              quiz.name.toString(),
              textAlign: TextAlign.center,
              style: Theme.of(context).primaryTextTheme.headline3,
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical! * 0.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding:
                      EdgeInsets.only(right: SizeConfig.safeBlockHorizontal!),
                  child: Icon(Icons.calendar_today,
                      size: SizeConfig.safeBlockHorizontal! * 4),
                ),
                Text(formatDateTime(quiz.startTime)['date'].toString()),
                SizedBox(
                  width: SizeConfig.safeBlockHorizontal! * 2,
                ),
                Padding(
                  padding:
                      EdgeInsets.only(right: SizeConfig.safeBlockHorizontal!),
                  child: Icon(
                    Icons.timelapse,
                    size: SizeConfig.safeBlockHorizontal! * 4,
                  ),
                ),
                Text(formatDateTime(quiz.startTime)['time'].toString()),
              ],
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical,
            ),
            Text(
              '30 Questions, ${calcuateTestDuration(quiz.startTime, quiz.endTime)} mins',
              style: Theme.of(context).primaryTextTheme.headline3!.copyWith(
                    fontSize: SizeConfig.safeBlockHorizontal! * 3,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
