import 'package:aptiche/utils/enums.dart';
import 'package:aptiche/utils/ui_scaling.dart';
import 'package:aptiche/views/quiz/quiz_controller.dart';
import 'package:aptiche/widgets/quiz/custom_radio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ChoicesListView extends GetView<QuizController> {
  const ChoicesListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List<Widget>.generate(
        4,
        (int index) => Column(
          children: <Widget>[
            Obx(
              () => CustomRadio(
                label: controller
                    .questions[controller.questionIndex.value].options[index],
                padding: EdgeInsets.zero,
                groupValue: controller.radioGroupValue.value,
                value: ChoicesEnum.values[index],
                onChanged: (ChoicesEnum newValue) {
                  controller.selectOption(newValue);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.safeBlockHorizontal! * 6,
              ),
              child: const Divider(),
            ),
          ],
        ),
      ),
    );
  }
}
