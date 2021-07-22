import 'package:aptiche/datamodels/api_models.dart';
import 'package:aptiche/services/net/authservice.dart';
import 'package:aptiche/services/graphql.dart';
import 'package:aptiche/utils/enums.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final AuthService _authService = Get.find();
  final GraphQLService _graphQLService = Get.find();

  RxBool upcomingQuizzes = true.obs;
  CurrentState homeState = CurrentState.busy;

  void init() async {
    _graphQLService.initGraphQL(await _authService.getUserToken());
  }

  @override
  void onInit() {
    getQuizzes();
    super.onInit();
  }

  void getQuizzes() async {
    List<Quiz> quizzes = [];
    await _graphQLService.getQuizzes();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
