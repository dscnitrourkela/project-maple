import 'package:aptiche/datamodels/api_models.dart';
import 'package:aptiche/utils/date_time.dart';
import 'package:aptiche/utils/string.dart';
import 'package:aptiche/utils/theme.dart';
import 'package:aptiche/utils/ui_scaling.dart';
import 'package:aptiche/views/quiz/quiz_controller.dart';
import 'package:aptiche/views/quiz/quiz_view.dart';
import 'package:aptiche/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class TestPreviewView extends GetView<QuizController> {
  const TestPreviewView({Key? key, required this.quiz}) : super(key: key);
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: SizeConfig.screenHeight! * 0.650,
              left: SizeConfig.screenWidth! * 0.175,
              right: SizeConfig.screenWidth! * 0.175,
              child: SvgPicture.asset(
                Strings.testPreviewScreenSVG,
                alignment: Alignment.center,
                placeholderBuilder: (BuildContext context) => Container(
                    padding: const EdgeInsets.all(30.0),
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator()),
                height: SizeConfig.screenHeight! * 0.30,
              ),
            ),
            Positioned(
              top: SizeConfig.screenHeight! * 0.375,
              height: SizeConfig.screenHeight! * 0.60,
              width: SizeConfig.screenWidth,
              child: Container(
                height: SizeConfig.screenHeight! * 0.4,
                padding: EdgeInsets.only(
                  top: SizeConfig.safeBlockVertical! * 4,
                ),
                decoration: BoxDecoration(
                  color: kGreyBgColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      SizeConfig.safeBlockHorizontal! * 10,
                    ),
                    topRight: Radius.circular(
                      SizeConfig.safeBlockHorizontal! * 10,
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.safeBlockHorizontal! * 10),
                  child: Column(
                    children: <Widget>[
                      Text(
                        quiz.name.toString(),
                        // 'APTITUDE TEST-1',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              color: kTextColourBlue,
                              fontWeight: FontWeight.w500,
                              fontSize: SizeConfig.safeBlockHorizontal! * 7.5,
                            ),
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical! * 4,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Instructions for the test:',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                fontSize: SizeConfig.safeBlockHorizontal! * 5,
                              ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical! * 4,
                      ),
                      Text(
                        '''
${quiz.instructions[0]}

${quiz.instructions[1]}

${quiz.instructions[2]}

Total time alloted for the whole test is ${calcuateTestDuration(quiz.startTime, quiz.endTime)} mins.
                      ''',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical! * 4,
                      ),
                      CustomButton(
                        onTap: () async {
                          debugPrint(quiz.quizId);
                          await controller.getQuestionsByQuiz(
                              <String>[quiz.quizId.toString()]);
                          Get.to<QuizView>(() => const QuizView());
                        },
                        text: 'Begin Test',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
