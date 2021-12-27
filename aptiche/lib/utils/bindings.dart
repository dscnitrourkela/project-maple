import 'package:aptiche/services/graphql.dart';
import 'package:aptiche/services/net/authservice.dart';
import 'package:aptiche/services/net/remote_config.dart';
import 'package:aptiche/services/theme_service.dart';
import 'package:aptiche/services/third_party_services.dart';
import 'package:aptiche/views/dataentry/dataentry_controller.dart';
import 'package:aptiche/views/home/home_controller.dart';
import 'package:aptiche/views/login/logincontroller.dart';
import 'package:aptiche/views/quiz/quiz_controller.dart';
import 'package:aptiche/views/splashscreen/user_controller.dart';
import 'package:get/get.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RemoteConfigService>(() => RemoteConfigService(), fenix: true);
    Get.lazyPut<GraphQLService>(() => GraphQLService(), fenix: true);
    Get.lazyPut<AuthService>(() => AuthService(), fenix: true);
    Get.lazyPut<ThemeService>(() => ThemeService(), fenix: true);
    Get.lazyPut<LoginController>(() => LoginController(), fenix: true);
    Get.lazyPut<ThirdPartyServices>(() => ThirdPartyServices(), fenix: true);
    Get.lazyPut<DataEntryController>(() => DataEntryController(), fenix: true);
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<QuizController>(() => QuizController(), fenix: true);
    Get.lazyPut<UserController>(() => UserController(), fenix: true);
  }
}
