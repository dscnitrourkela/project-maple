import 'dart:async';
import 'package:aptiche/datamodels/api_models.dart';
import 'package:aptiche/services/graphql.dart';
import 'package:aptiche/utils/enums.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class QuizController extends GetxController {
  // Variables
  final GetStorage localQuizStorage = GetStorage('Quiz');

  /// Finds the [GraphQLService] using [Getx] dependency injection
  final GraphQLService _graphQLService = Get.find();

  /// Stores the current value of the radio(selected option) of the question.
  Rx<ChoicesEnum> radioGroupValue = ChoicesEnum.NON.obs;

  /// Late initialises [Timer].
  late Timer timer;

  /// Stores the value of the timer.
  Rx<Duration> timeout = const Duration(hours: 1).obs;

  /// Stores the list of all question of that quiz.
  late List<Question> questions;

  /// Stores th current index of the question displyed in the quiz.
  Rx<int> questionIndex = 0.obs;

  ///Stores whether the drop down is open or not.
  Rx<bool> dropDownOpen = false.obs;

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

  /// Clears [radioGroupValue] and sets to [ChoicesEnum.NON]
  void clearRadioGroup() {
    radioGroupValue.value = ChoicesEnum.NON;
  }

  /// A future that fetches a list of [Question] objects for the Quiz.
  Future<void> getQuestionsByQuiz(List<String> ids) async {
    questions = await _graphQLService.getQuestionsByQuiz(ids);
    update();
  }

  /// A function which assigns the selected option of the current question to
  /// the choice variable of [Question] and shows the next question in the quiz.
  void saveAndNext() {
    questions[questionIndex.value].choice =
        questions[questionIndex.value].options[radioGroupValue.value.index];

    // The radio group value has to be set to NON for the next question.
    if (questions[questionIndex.value].choice == null) {
      radioGroupValue.value = ChoicesEnum.NON;
    }

    questionIndex.value++;

    //TODO:To show the saved answer if any for the next quiz.
  }

  /// A function when triggered shows the previous question in the quiz.
  void previous() {
    questions[questionIndex.value].choice =
        questions[questionIndex.value].options[radioGroupValue.value.index];
    if (questions[questionIndex.value].choice == null) {
      radioGroupValue.value = ChoicesEnum.NON;
    }
    questionIndex.value--;

    //TODO:To show the saved answer of the previous question.
  }

  /// A function that calculates the total score of the user.
  int calculateScore() {
    // This is done so that the last entry of the user gets saved.
    questions[questionIndex.value].choice =
        questions[questionIndex.value].options[radioGroupValue.value.index];

    /// Stores the score of the user for that quiz.
    int score = 0;

    for (final Question question in questions) {
      if (question.choice == question.answer) {
        // adds the positive marks when the user answers correct/
        score = score + question.positiveMark;
      } else if (question.choice == null) {
        // doesn't change the score when left unasnwered.
        score = score;
      } else {
        // adds the negative mark when answered incorrect.
        score = score + question.negativeMark;
      }
    }
    return score;
  }

  ///store the score in the local storage.
  Future<void> storeScore(String quizId, int score) async {
    await localQuizStorage.write(quizId, score);
  }

  ///Function to check whether the quiz is taken already or not.
  bool checkQuiz(String quizId) {
    return localQuizStorage.read<String>(quizId) == null;
  }

  @override
  // ignore: unnecessary_overrides
  void onClose() {
    super.onClose();
  }
}
