import 'package:aptiche/net/authservice.dart';
import 'package:aptiche/views/login/logincontroller.dart';
import 'package:get/instance_manager.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AuthService>(AuthService());
    Get.put<LoginController>(LoginController());
  }
}
