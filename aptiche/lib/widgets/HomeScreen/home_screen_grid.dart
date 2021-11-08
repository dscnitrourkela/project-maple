import 'package:aptiche/datamodels/api_models.dart';
import 'package:aptiche/utils/date_time.dart';
import 'package:aptiche/utils/string.dart';
import 'package:aptiche/utils/theme.dart';
import 'package:aptiche/utils/ui_scaling.dart';
import 'package:aptiche/views/quiz/answer_view.dart';
import 'package:aptiche/views/testpreview/test_preview_view.dart';
import 'package:aptiche/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeGridTile extends StatelessWidget {
  const HomeGridTile({
    Key? key,
    required this.quiz,
    required this.classifier,
  }) : super(key: key);

  final Quiz quiz;
  final bool classifier;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (classifier == true) {
          CustomLoaders().customSnackBar(
            'You are trying to attempt a future quiz',
            '${quiz.name} will be active on ${formatDateTime(quiz.startTime)['date'].toString()}',
          );
        } else {
          Get.to<AnswerView>(() => AnswerView(quiz));
        }
      },
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
              width: SizeConfig.safeBlockHorizontal! * 18,
              height: SizeConfig.safeBlockVertical! * 9,
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
              'Duration - ${calcuateTestDuration(quiz.startTime, quiz.endTime)} mins',
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

class HomeActiveTile extends StatelessWidget {
  const HomeActiveTile({
    Key? key,
    required this.quiz,
  }) : super(key: key);

  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => Get.to<TestPreviewView>(
              () => TestPreviewView(
                quiz: quiz,
              ),
            ),
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenWidth! * 0.05,
            vertical: SizeConfig.screenWidth! * 0.02,
          ),

          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(SizeConfig.safeBlockHorizontal! * 6.25),
            gradient: LinearGradient(
              end: Alignment.centerLeft,
              begin: Alignment.centerRight,
              colors: <Color>[
                kTertiaryColor.withOpacity(0.7),
                kPrimaryColor,
                kSecondaryColor,
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.safeBlockHorizontal! * 4.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image.asset(
                  'assets/images/live.png',
                  height: SizeConfig.safeBlockHorizontal! * 15,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      quiz.name.toString(),
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .primaryTextTheme
                          .headline2!
                          .copyWith(color: kBgColour),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              right: SizeConfig.safeBlockHorizontal!),
                          child: Icon(Icons.timelapse,
                              color: kBgColour,
                              size: SizeConfig.safeBlockHorizontal! * 6),
                        ),
                        Text(
                          '${formatDateTime(quiz.startTime)['time']} - ${formatDateTime(quiz.endTime)['time']}',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .primaryTextTheme
                              .headline2!
                              .copyWith(
                                  color: kBgColour,
                                  fontSize:
                                      SizeConfig.safeBlockHorizontal! * 5),
                        ),
                      ],
                    ),
                    Text(
                      '${quiz.questionIds.length} Questions',
                      style: Theme.of(context)
                          .primaryTextTheme
                          .headline2!
                          .copyWith(
                            fontSize: SizeConfig.safeBlockHorizontal! * 5,
                            color: kBgColour,
                          ),
                    ),
                  ],
                )
              ],
            ),
          ),
          //child: Text(quiz.quizId.toString()),
        ));
  }
}
