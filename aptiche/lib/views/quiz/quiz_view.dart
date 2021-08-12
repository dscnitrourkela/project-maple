import 'package:aptiche/utils/ui_scaling.dart';
import 'package:aptiche/views/quiz/quiz_controller.dart';
import 'package:aptiche/widgets/buttons.dart';
import 'package:aptiche/widgets/quiz/choices_list_view.dart';
import 'package:aptiche/widgets/quiz/quiz_question.dart';
import 'package:aptiche/widgets/quiz/quiz_timer.dart';
import 'package:aptiche/widgets/quiz/quiz_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class QuizView extends GetView<QuizController> {
  const QuizView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.safeBlockHorizontal! * 2,
          vertical: SizeConfig.safeBlockVertical!,
        ),
        height: SizeConfig.screenHeight! * 0.075,
        alignment: Alignment.bottomCenter,
        color: Colors.white,
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (controller.questionIndex.value > 0)
                CustomButton(
                  horizontalPadding: SizeConfig.safeBlockHorizontal! * 1.6,
                  verticalPadding: SizeConfig.safeBlockVertical! * 0.27,
                  text: 'Previous',
                  onTap: () {
                    controller.previous();
                  },
                ),
              if (controller.questionIndex.value + 1 <
                  controller.questions.length)
                CustomButton(
                  horizontalPadding: SizeConfig.safeBlockHorizontal! * 1.6,
                  verticalPadding: SizeConfig.safeBlockVertical! * 0.27,
                  text: 'Save & Next',
                  onTap: () {
                    controller.saveAndNext();
                  },
                ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const QuizTimer(),
              SizedBox(
                height: SizeConfig.safeBlockVertical! * 0.4,
              ),
              const QuizTopBar(),
              const Divider(),
              SizedBox(
                height: SizeConfig.safeBlockVertical! * 2,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.safeBlockHorizontal! * 2),
                child: Obx(
                  () => Text(
                    'Question ${controller.questionIndex.value + 1}',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical! * 4,
              ),
              const QuizQuestion(),
              SizedBox(
                height: SizeConfig.safeBlockVertical! * 2,
              ),
              const ChoicesListView(),
              // TODO: A button must be provided to clear the selected option.
            ],
          ),
        ),
      ),
    );
  }
}
