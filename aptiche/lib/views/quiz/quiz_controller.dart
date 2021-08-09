import 'dart:async';
import 'package:aptiche/datamodels/api_models.dart';
import 'package:aptiche/services/graphql.dart';
import 'package:aptiche/utils/enums.dart';
import 'package:get/get.dart';

class QuizController extends GetxController {
  // Variables

  /// Finds the [GraphQLService] using [Getx] dependency injection
  final GraphQLService _graphQLService = Get.find();

  /// Stores the current value of the radio(selected option) of the question.
  Rx<ChoicesEnum> radioGroupValue = ChoicesEnum.NON.obs;

  /// Late initialises [Timer].
  late Timer timer;

  /// Stores the value of the timer.
  Rx<Duration> timeout = const Duration(hours: 1).obs;

  late List<Question> questions;

  Rx<int> questionIndex = 0.obs;

  // Functions

  /// A void function which controls the behaviour of the timer(`timeout`)
  void startTimeout() {
    const Duration oneSec = Duration(seconds: 1);
    timer = Timer.periodic(oneSec, (Timer timer) {
      if (timeout.value.inSeconds == 0) {
        timer.cancel();
      } else {
        timeout.value = timeout.value - oneSec;
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  /// Changes [radioGroupValue] to the selected option.
  void selectOption(ChoicesEnum newValue) {
    radioGroupValue.value = newValue;
  }

  /// A future that fetches a list of [Question] objects for the Quiz.
  Future<void> getQuestionsByQuiz(List<String> ids) async {
    questions = await _graphQLService.getQuestionsByQuiz(ids);
    update();
  }

  void saveAndNext() {
    questions[questionIndex.value].choice =
        questions[questionIndex.value].options[radioGroupValue.value.index];
    questionIndex.value++;
    radioGroupValue.value = ChoicesEnum.NON;
  }

  void previous() {
    questionIndex.value--;
  }

  void calculateScore() {
    questions[questionIndex.value].choice =
        questions[questionIndex.value].options[radioGroupValue.value.index];
    int score = 0;
    for (final Question question in questions) {
      if (question.choice == question.answer) {
        score = score + 3;
      } else if (question.choice == null) {
        score = score;
      } else {
        score--;
      }
    }

    print('score: $score');
  }

  @override
  // ignore: unnecessary_overrides
  void onClose() {
    super.onClose();
  }
}
