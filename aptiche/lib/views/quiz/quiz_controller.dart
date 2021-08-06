import 'dart:async';
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
  late Timer _timer;

  /// Stores the value of the timer.
  Rx<Duration> timeout = const Duration(hours: 1).obs;

  // Functions

  /// A void function which controls the behaviour of the timer(`timeout`)
  void startTimeout() {
    const Duration oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (timeout.value.inSeconds == 0) {
        timer.cancel();
      } else {
        timeout.value = timeout.value - oneSec;
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  /// Changes [radioGroupValue] to the selected option.
  void selectOption(ChoicesEnum newValue) {
    radioGroupValue.value = newValue;
  }

  /// A future that fetches a list of [Question] objects for the Quiz.
  Future<void> getQuestionsByQuiz(List<String> ids) async {
    await _graphQLService.getQuestionsByQuiz(ids);
  }
}
