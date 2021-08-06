import 'package:aptiche/utils/enums.dart';
import 'package:aptiche/utils/ui_scaling.dart';
import 'package:aptiche/views/quiz/quiz_controller.dart';
import 'package:aptiche/widgets/quiz/custom_radio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ChoicesListView extends StatelessWidget {
  const ChoicesListView({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final QuizController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (BuildContext context, int index) => Column(
        children: <Widget>[
          Obx(
            () => CustomRadio(
              label: '14',
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
    );
  }
}
