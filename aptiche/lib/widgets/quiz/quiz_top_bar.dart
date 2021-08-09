import 'package:aptiche/utils/ui_scaling.dart';
import 'package:aptiche/views/home/homescreen.dart';
import 'package:aptiche/views/quiz/quiz_controller.dart';
import 'package:aptiche/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
            //TODO: Decide if it's going to be a dropdown list or something else and implement
            Text(
              '${controller.questionIndex.value + 1} of ${controller.questions.length}',
              style: Theme.of(context).textTheme.headline6,
            ),
            CustomButton(
              text: 'Finish',
              onTap: () {
                controller.calculateScore();
                controller.timer.cancel();
                Get.off<HomeScreen>(() => const HomeScreen());
              },
              horizontalPadding: 7,
              verticalPadding: 2,
            )
          ],
        ),
      ),
    );
  }
}
