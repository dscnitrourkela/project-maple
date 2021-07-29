import 'package:aptiche/services/graphql.dart';
import 'package:aptiche/services/net/authservice.dart';
import 'package:aptiche/services/third_party_services.dart';
import 'package:aptiche/views/dataentry/dataentry_controller.dart';
import 'package:aptiche/views/home/home_controller.dart';
import 'package:aptiche/views/login/logincontroller.dart';
import 'package:aptiche/views/quiz/quiz_view.dart';
import 'package:get/instance_manager.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<GraphQLService>(GraphQLService());
    Get.put<AuthService>(AuthService());
    Get.put<LoginController>(LoginController());
    Get.put<ThirdPartyServices>(ThirdPartyServices());
    Get.lazyPut<DataEntryController>(() => DataEntryController(), fenix: true);
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut(() => const QuizView(), fenix: true);
  }
}
