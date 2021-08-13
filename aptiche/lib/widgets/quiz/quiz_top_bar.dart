import 'package:aptiche/utils/theme.dart';
import 'package:aptiche/utils/ui_scaling.dart';
import 'package:aptiche/views/home/homescreen.dart';
import 'package:aptiche/views/quiz/quiz_controller.dart';
import 'package:aptiche/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:awesome_dropdown/awesome_dropdown.dart';

class QuizTopBar extends GetView<QuizController> {
  const QuizTopBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockHorizontal! * 2),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              height: SizeConfig.safeBlockHorizontal! * 14,
              width: SizeConfig.screenWidth! * 0.39,
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
                  dropDownListTextStyle:
                      Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: kTextColourBlue,
                          ),
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
                  },
                  selectedItem:
                      'Question ${controller.questionIndex.value + 1}',
                  dropDownList: List<String>.generate(
                      controller.questions.length,
                      (int index) => 'Question ${index + 1}')),
            ),
            CustomButton(
              text: 'Finish',
              // TODO: After pressing finish, everything must be stored into local storage and the next time the users opens the same quiz, timer and dinish button must not be shown.
              onTap: () {
                controller.calculateScore();
                controller.timer.cancel();
                Get.off<HomeScreen>(() => const HomeScreen());
              },
              horizontalPadding: SizeConfig.safeBlockHorizontal! * 1.6,
              verticalPadding: SizeConfig.safeBlockVertical! * 0.27,
            )
          ],
        ),
      ),
    );
  }
}
