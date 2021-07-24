import 'package:aptiche/services/net/authservice.dart';
import 'package:aptiche/services/graphql.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final AuthService _authService = Get.find();
  final GraphQLService _graphQLService = Get.find();

  void init() async {
    _graphQLService.initGraphQL(await _authService.getUserToken());
  }

  RxBool upcomingQuizzes = true.obs;
}
