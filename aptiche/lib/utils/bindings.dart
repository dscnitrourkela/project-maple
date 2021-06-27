import 'package:aptiche/net/authservice.dart';
import 'package:aptiche/views/data%20entry/dataentry_controller.dart';
import 'package:aptiche/views/home/home_controller.dart';
import 'package:aptiche/views/login/logincontroller.dart';
import 'package:get/instance_manager.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AuthService>(AuthService());
    Get.put<LoginController>(LoginController());
    Get.put<DataEntryController>(DataEntryController());
    Get.put<HomeController>(HomeController());
  }
}
