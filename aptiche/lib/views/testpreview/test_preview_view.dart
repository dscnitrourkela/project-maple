import 'package:aptiche/datamodels/api_models.dart';
import 'package:aptiche/utils/date_time.dart';
import 'package:aptiche/utils/string.dart';
import 'package:aptiche/utils/theme.dart';
import 'package:aptiche/utils/ui_scaling.dart';
import 'package:aptiche/views/quiz/quiz_controller.dart';
import 'package:aptiche/views/quiz/quiz_view.dart';
import 'package:aptiche/widgets/buttons.dart';
import 'package:aptiche/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class TestPreviewView extends GetView<QuizController> {
  TestPreviewView({Key? key, required this.quiz}) : super(key: key);
  final Quiz quiz;
  List<String> instructions = <String>[];
  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < quiz.instructions.length; i++) {
      instructions.add('${i + 1}.  ${quiz.instructions[i]}');
    }
    instructions.add(
      '${quiz.instructions.length + 1}. Total time alloted for the whole test is ${calcuateTestDuration(quiz.startTime, quiz.endTime)} mins.',
    );
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
              top: SizeConfig.screenHeight! * 0.355,
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Text(
                          quiz.name.toString(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(
                                color: kTextColourBlue,
                                fontWeight: FontWeight.w700,
                                fontSize: SizeConfig.safeBlockHorizontal! * 7.5,
                              ),
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical! * 3,
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
                                  color: kTextColourBlack,
                                ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical! * 2,
                        ),
                        ListView.builder(
                            itemCount: instructions.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Text(
                                instructions[index],
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal! *
                                              3.75,
                                      color: kTextColourBlack,
                                    ),
                                textAlign: TextAlign.left,
                              );
                            }),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical! * 4,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: SizeConfig.safeBlockVertical! * 2),
                          child: CustomButton(
                            horizontalPadding:
                                SizeConfig.safeBlockHorizontal! * 3.5,
                            verticalPadding:
                                SizeConfig.safeBlockVertical! * 0.27,
                            onTap: () async {
                              await controller
                                  .getQuestionsByQuiz(<String>[quiz.quizId!]);
                              if (!controller.checkIfAttempted(quiz.quizId!)) {
                                controller.startTimeout(quiz);
                                Get.to<QuizView>(() => QuizView(quiz: quiz));
                              } else {
                                CustomLoaders().customSnackBar(
                                    'Duplicate Test Attempt',
                                    'You are attempting a test that you have already attempted. Multiple attempts not allowed');
                              }
                            },
                            text: 'Begin Test',
                          ),
                        ),
                      ],
                    ),
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
