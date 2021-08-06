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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CustomButton(
              horizontalPadding: 7,
              verticalPadding: 2,
              text: 'Previous',
              onTap: () {},
            ),
            CustomButton(
              horizontalPadding: 7,
              verticalPadding: 2,
              text: 'Save & Next',
              onTap: () {},
            ),
          ],
        ),
      ),
      body: SafeArea(
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
              child: Text(
                'Question 14',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical! * 4,
            ),
            const QuizQuestion(),
            SizedBox(
              height: SizeConfig.safeBlockVertical! * 2,
            ),
            ChoicesListView(controller: controller),
          ],
        ),
      ),
    );
  }
}
