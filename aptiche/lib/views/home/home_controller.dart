import 'package:aptiche/datamodels/api_models.dart';
import 'package:aptiche/services/graphql.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final GraphQLService _graphQL = Get.find();
  RxBool upcomingQuizzes = true.obs;

  late List<Quiz> quizzes;

  Future<void> getQuizzes() async {
    //quizzes = await _graphQL.getQuizzes();
  }
}
