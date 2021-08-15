import 'package:aptiche/datamodels/api_models.dart';
import 'package:aptiche/utils/ui_scaling.dart';
import 'package:aptiche/views/home/homescreen.dart';
import 'package:aptiche/views/quiz/quiz_controller.dart';
import 'package:aptiche/widgets/buttons.dart';
import 'package:aptiche/widgets/quiz/choices_list_view.dart';
import 'package:aptiche/widgets/quiz/quiz_question.dart';
import 'package:aptiche/widgets/quiz/quiz_timer.dart';
import 'package:aptiche/widgets/quiz/quiz_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuizView extends GetView<QuizController> {
  const QuizView({
    Key? key,
    required this.quiz,
  }) : super(key: key);
  final Quiz quiz;
  @override
  Widget build(BuildContext context) {
    print(controller.questionIndex.value);
    return WillPopScope(
      onWillPop: () {
        showDialog<bool>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: const Text('Are you sure you want to end the quiz?'),
                  content: const Text(
                      'You are trying to exit the quiz and doing so will end your ony attempt for this quiz. Do you want to exit? '),
                  actions: <Widget>[
                    CustomButton(
                      horizontalPadding: SizeConfig.safeBlockHorizontal! * 1.4,
                      verticalPadding: SizeConfig.safeBlockVertical! * 0.27,
                      text: 'END QUIZ',
                      onTap: () async {
                        await controller.storeScore(
                          quiz.name.toString(),
                          controller.calculateScore(),
                        );
                        controller.timer.cancel();
                        Get.off<HomeScreen>(() => const HomeScreen());
                      },
                    ),
                    CustomButton(
                      horizontalPadding: SizeConfig.safeBlockHorizontal! * 1.4,
                      verticalPadding: SizeConfig.safeBlockVertical! * 0.27,
                      text: 'CANCEL',
                      onTap: () async {
                        Get.back<QuizView>();
                      },
                    )
                  ],
                ));

        return Future<bool>.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            quiz.name.toString(),
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(fontSize: SizeConfig.safeBlockVertical! * 3.5),
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.safeBlockHorizontal! * 2,
            vertical: SizeConfig.safeBlockVertical!,
          ),
          height: SizeConfig.screenHeight! * 0.075,
          alignment: Alignment.bottomCenter,
          color: Colors.white,
          child: Obx(
            () => Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.safeBlockHorizontal! * 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  if (controller.questionIndex.value > 0)
                    CustomButton(
                      horizontalPadding: SizeConfig.safeBlockHorizontal! * 1.4,
                      verticalPadding: SizeConfig.safeBlockVertical! * 0.27,
                      text: 'Previous',
                      onTap: () {
                        controller.previous();
                      },
                    ),
                  CustomButton(
                    horizontalPadding: SizeConfig.safeBlockHorizontal! * 1.4,
                    verticalPadding: SizeConfig.safeBlockVertical! * 0.27,
                    text: 'Clear Choice',
                    onTap: () {
                      controller.clearRadioGroup();
                    },
                  ),
                  if (controller.questionIndex.value + 1 <
                      controller.questions.length)
                    CustomButton(
                      horizontalPadding: SizeConfig.safeBlockHorizontal! * 1.4,
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
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const QuizTimer(),
                SizedBox(
                  height: SizeConfig.safeBlockVertical! * 0.4,
                ),
                QuizTopBar(quiz.name!.toString()),
                const Divider(),
                SizedBox(
                  height: SizeConfig.safeBlockVertical! * 2,
                ),
                // Container(
                //   alignment: Alignment.centerLeft,
                //   padding: EdgeInsets.symmetric(
                //       horizontal: SizeConfig.safeBlockHorizontal! * 2),
                //   child: Obx(
                //     () => Text(
                //       'Question ${controller.questionIndex.value + 1}',
                //       style: Theme.of(context).textTheme.headline6,
                //     ),
                //   ),
                // ),

                const QuizQuestion(),
                SizedBox(
                  height: SizeConfig.safeBlockVertical! * 2,
                ),
                const ChoicesListView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
