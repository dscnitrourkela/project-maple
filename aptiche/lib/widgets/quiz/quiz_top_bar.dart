import 'package:aptiche/datamodels/api_models.dart';
import 'package:aptiche/utils/theme.dart';
import 'package:aptiche/utils/ui_scaling.dart';
import 'package:aptiche/views/quiz/quiz_controller.dart';
import 'package:aptiche/views/quiz/quiz_view.dart';
import 'package:aptiche/views/result/result_view.dart';
import 'package:aptiche/widgets/buttons.dart';
import 'package:awesome_dropdown/awesome_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuizTopBar extends GetView<QuizController> {
  const QuizTopBar(
    this.quiz, {
    Key? key,
  }) : super(key: key);
  final Quiz quiz;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.safeBlockHorizontal! * 2,
      ),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: SizeConfig.safeBlockHorizontal! * 16,
              width: SizeConfig.screenWidth! * 0.42,
              child: AwesomeDropDown(
                  isPanDown: controller.dropDownOpen.value,
                  dropDownBGColor: kBgColour,
                  dropDownOverlayBGColor: Colors.transparent,
                  padding: SizeConfig.safeBlockHorizontal! * 2,
                  dropDownIcon: const Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                      size: 23,
                    ),
                  ),
                  dropDownListTextStyle: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(
                          color: kTextColourBlue,
                          fontSize: SizeConfig.safeBlockHorizontal! * 5),
                  elevation: 10,
                  dropDownBorderRadius: SizeConfig.safeBlockHorizontal!,
                  dropDownTopBorderRadius: SizeConfig.safeBlockHorizontal! * 5,
                  dropDownBottomBorderRadius:
                      SizeConfig.safeBlockHorizontal! * 5,
                  dropDownIconBGColor: Colors.transparent,
                  numOfListItemToShow: 5,
                  onDropDownItemClick: (String item) {
                    controller.dropDownOpen.value = false;

                    controller.questionIndex.value =
                        int.parse(item.substring(9)) - 1;
                    controller.checkAnswered();
                  },
                  selectedItem:
                      'Question ${controller.questionIndex.value + 1}',
                  dropDownList: List<String>.generate(
                      controller.questions.length,
                      (int index) => 'Question ${index + 1}')),
            ),
            CustomButton(
              text: 'Finish',
              onTap: () async {
                await showDialog<bool>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: const Text(
                              'Are you sure you want to submit the quiz?'),
                          content: const Text(
                            'You are trying to exit the quiz and doing so will end your only attempt for this quiz. Do you want to exit? ',
                          ),
                          actions: <Widget>[
                            CustomButton(
                              horizontalPadding:
                                  SizeConfig.safeBlockHorizontal! * 1.4,
                              verticalPadding:
                                  SizeConfig.safeBlockVertical! * 0.27,
                              text: 'END QUIZ',
                              onTap: () async {
                                controller.calculateScore();
                                await controller.storeScore(
                                  quiz.name.toString(),
                                );
                                controller.timer.cancel();
                                await Get.off<ResultView>(
                                  () => ResultView(
                                    score: controller.userScore.value,
                                    totalScore: controller.questions.length *
                                        controller.questions[0].positiveMark,
                                  ),
                                );
                              },
                            ),
                            CustomButton(
                              horizontalPadding:
                                  SizeConfig.safeBlockHorizontal! * 1.4,
                              verticalPadding:
                                  SizeConfig.safeBlockVertical! * 0.27,
                              text: 'CANCEL',
                              onTap: () async {
                                Get.back<QuizView>();
                              },
                            )
                          ],
                        ));
              },
              horizontalPadding: SizeConfig.safeBlockHorizontal! * 1.6,
              verticalPadding: SizeConfig.safeBlockVertical! * 0.5,
            )
          ],
        ),
      ),
    );
  }
}
