import 'package:aptiche/services/graphql.dart';
import 'package:aptiche/utils/enums.dart';
import 'package:get/get.dart';

class QuizController extends GetxController {
  final GraphQLService _graphQLService = Get.find();
  Rx<ChoicesEnum> radioGroupValue = ChoicesEnum.NON.obs;

  void selectOption(ChoicesEnum newValue) {
    radioGroupValue.value = newValue;
  }

  Future<void> getQuestionsByQuiz(List<String> ids) async {
    await _graphQLService.getQuestionsByQuiz(ids);
  }
}
