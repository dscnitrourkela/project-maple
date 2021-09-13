import 'dart:async';
import 'package:aptiche/datamodels/api_models.dart';
import 'package:aptiche/services/graphql.dart';
import 'package:aptiche/utils/date_time.dart';
import 'package:aptiche/utils/enums.dart';
import 'package:aptiche/views/result/result_view.dart';
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
  Rx<Duration> timeout = const Duration().obs;

  /// Stores the list of all question of that quiz.
  late List<Question> questions;

  /// Stores th current index of the question displyed in the quiz.
  Rx<int> questionIndex = 0.obs;

  ///Stores whether the drop down is open or not.
  Rx<bool> dropDownOpen = false.obs;

  ///Stores the user score of the quiz
  Rx<int> userScore = 0.obs;

  // Functions

  /// A void function which controls the behaviour of the timer(`timeout`)
  void startTimeout(Quiz quiz) {
    timeout.value =
        Duration(minutes: calcuateTestDuration(quiz.startTime, quiz.endTime));
    const Duration oneSec = Duration(seconds: 1);
    timer = Timer.periodic(oneSec, (Timer timer) async {
      if (timeout.value.inSeconds == 0) {
        calculateScore();
        await storeScore(
          quiz.name.toString(),
        );
        timer.cancel();
        Get.off<ResultView>(
          () => ResultView(
            score: userScore.value,
            totalScore: questions.length * questions[0].positiveMark,
          ),
        );
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

  /// Checks whether the question is answered or not
  void checkAnswered() {
    if (questions[questionIndex.value].choice == null) {
      radioGroupValue.value = ChoicesEnum.NON;
    } else {
      radioGroupValue.value = ChoicesEnum.values.elementAt(
        questions[questionIndex.value].options.indexOf(
              questions[questionIndex.value].choice.toString(),
            ),
      );
    }
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
    if (radioGroupValue.value.index != 4) {
      questions[questionIndex.value].choice =
          questions[questionIndex.value].options[radioGroupValue.value.index];
    } else {
      questions[questionIndex.value].choice = null;
    }

    if (questionIndex.value + 1 != questions.length) {
      questionIndex.value++;
    }
    checkAnswered();
  }

  /// A function when triggered shows the previous question in the quiz.
  void previous() {
    if (radioGroupValue.value.index != 4) {
      questions[questionIndex.value].choice =
          questions[questionIndex.value].options[radioGroupValue.value.index];
    } else {
      questions[questionIndex.value].choice = null;
    }

    questionIndex.value--;
    checkAnswered();
  }

  /// A function that calculates the total score of the user.
  void calculateScore() {
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
    userScore.value = score;
  }

  ///store the score in the local storage.
  Future<void> storeScore(String quizId) async {
    final Map? result = localQuizStorage.read<Map>('past');
    if (result != null) {
      result[quizId] = userScore.value.toString();
      localQuizStorage.save();
    } else {
      final Map<String, String> map = <String, String>{
        quizId: userScore.value.toString()
      };
      localQuizStorage.write('past', map);
    }
  }

  ///Function to check whether the quiz is taken already or not.
  // ignore_for_file: always_specify_types
  bool checkIfAttempted(String quizId) {
    final Map? result = localQuizStorage.read<Map>('past');
    if (result != null && result[quizId] != null) {
      // result.forEach((dynamic key, dynamic value) {
      //   print('$key : $value');
      // });
      return true;
    } else {
      return false;
    }
  }

  String score(String quizId) =>
      localQuizStorage.read<Map>('past')![quizId].toString();

  @override
  // ignore: unnecessary_overrides
  void onClose() {
    super.onClose();
  }
}
