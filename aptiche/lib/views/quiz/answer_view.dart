import 'package:aptiche/datamodels/api_models.dart';
import 'package:aptiche/utils/theme.dart';
import 'package:aptiche/utils/ui_scaling.dart';
import 'package:aptiche/views/quiz/quiz_controller.dart';
import 'package:aptiche/widgets/quiz/ans_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnswerView extends GetView<QuizController> {
  const AnswerView(this.quiz, {Key? key}) : super(key: key);
  final Quiz quiz;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          // color: kTextColourBlue,
          onPressed: () {
            Get.back<dynamic>();
          },
        ),
        title: Text(
          quiz.name.toString(),
          style: Theme.of(context).primaryTextTheme.headline2,
        ),
      ),
      body: FutureBuilder<void>(
        future: controller.getQuestionsByQuiz(<String>[quiz.quizId.toString()]),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: kPrimaryColor,
              ),
            );
          }
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.all(
                SizeConfig.safeBlockHorizontal! * 2,
              ),
              child: SizedBox(
                height: SizeConfig.screenHeight,
                width: SizeConfig.screenWidth,
                child: ListView.builder(
                    itemCount: controller.questions.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return AnswerDisplayer(
                        question: controller.questions[index].question,
                        answer: controller.questions[index].answer,
                        index: index + 1,
                      );
                    }),
              ),
            ),
          );
        },
      ),
    );
  }
}



//  future: controller.getQuestionsByQuiz(<String>[quiz.quizId.toString()]),