import 'package:aptiche/utils/theme.dart';
import 'package:aptiche/utils/ui_scaling.dart';

import 'package:aptiche/views/quiz/quiz_controller.dart';
import 'package:aptiche/views/result/result_view.dart';
import 'package:aptiche/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:awesome_dropdown/awesome_dropdown.dart';

class QuizTopBar extends GetView<QuizController> {
  const QuizTopBar(
    this.quizName, {
    Key? key,
  }) : super(key: key);
  final String quizName;
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
                controller.calculateScore();
                await controller.storeScore(
                  quizName.toString(),
                );
                controller.timer.cancel();

                Get.off<ResultView>(
                  () => ResultView(
                    score: controller.score.value,
                    totalScore: controller.questions.length *
                        controller.questions[0].positiveMark,
                  ),
                );
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
