import 'package:aptiche/utils/ui_scaling.dart';
import 'package:aptiche/views/quiz/quiz_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class QuizQuestion extends GetView<QuizController> {
  const QuizQuestion({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockHorizontal! * 4),
      child: Obx(
        () => Text(
          controller.questions[controller.questionIndex.value].question
              .toString(),
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                height: SizeConfig.safeBlockHorizontal! * 0.4,
                fontSize: SizeConfig.safeBlockVertical! * 2.35,
              ),
        ),
      ),
    );
  }
}
