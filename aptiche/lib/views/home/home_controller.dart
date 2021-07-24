import 'package:aptiche/datamodels/api_models.dart';
import 'package:aptiche/services/net/authservice.dart';
import 'package:aptiche/services/graphql.dart';
import 'package:aptiche/utils/enums.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final GraphQLService _graphQL = Get.find();
  final AuthService _authService = Get.find();
  RxBool upcomingQuiz = true.obs;
  CurrentState homeState = CurrentState.busy;

  late List<Quiz> quizzes;
  List<Quiz> upcomingQuizzes = <Quiz>[];
  List<Quiz> pastQuizzes = <Quiz>[];
  List<Quiz> desiredList = <Quiz>[];

  @override
  void onInit() {
    getQuizzes();
    super.onInit();
  }

  void init() async {
    _graphQL.initGraphQL(await _authService.getUserToken());
  }

  void assignList() {
    (upcomingQuiz.value)
        ? desiredList = upcomingQuizzes
        : desiredList = pastQuizzes;
    update();
  }

  Future<void> getQuizzes() async {
    homeState = CurrentState.busy;
    quizzes = await _graphQL.getQuizzes();
    if ((upcomingQuizzes.length + pastQuizzes.length) != quizzes.length)
      for (final Quiz quiz in quizzes) {
        if (quiz.active) {
          upcomingQuizzes.add(quiz);
        }
        if (!quiz.active) {
          pastQuizzes.add(quiz);
        }
      }
    homeState = CurrentState.ready;
    update();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
