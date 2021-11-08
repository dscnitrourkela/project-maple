// ignore_for_file: always_specify_types

import 'package:aptiche/datamodels/api_models.dart';
import 'package:aptiche/services/graphql.dart';
import 'package:aptiche/utils/enums.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  /// Finds the [GraphQLService] using [Getx] dependency injection
  final GraphQLService _graphQL = Get.find();

  /// A boolean which returns true if the user has chose to display upcoming
  /// quizzes
  RxBool upcomingQuiz = false.obs;

  /// An enum which stores the current state of the [HomeScreen]
  Rx<CurrentState> homeState = CurrentState.ready.obs;

  /// A list which stores all the active quizzes.
  List<Quiz> activeQuizzes = [];

  /// A list whioch stores all the upcoming quizzes.
  List<Quiz> upcomingQuizzes = [];

  /// A list which stores all the past quizzes.
  List<Quiz> pastQuizzes = [];

  /// A list which stores either `activeQuizzes`, `upcomingQuizzes` or
  /// `pastQuizzes` depending on what the user selects.
  List<Quiz> desiredList = [];

  @override
  void onInit() {
    getQuizzes();
    super.onInit();
  }

  /// The function assigns a list the desiredList depending on the user's
  /// requirement.
  void assignList() async {
    homeState.value = CurrentState.busy;
    (upcomingQuiz.value)
        ? desiredList = upcomingQuizzes
        : desiredList = pastQuizzes;
    homeState.value = CurrentState.ready;
    update();
  }

  /// The function calls the getQuizzesByTime query from [GraphQLService] and
  /// assigns the results to the respective quiz.
  Future<void> getQuizzes() async {
    homeState.value = CurrentState.busy;
    pastQuizzes = await _graphQL.getQuizzesByTime(1);
    activeQuizzes = await _graphQL.getQuizzesByTime(2);
    upcomingQuizzes = await _graphQL.getQuizzesByTime(3);
    assignList();
    homeState.value = CurrentState.ready;
    update();
  }

  @override
  // ignore: unnecessary_overrides
  void onClose() {
    super.onClose();
  }
}
