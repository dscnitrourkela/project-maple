import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DataEntryController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController rollNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
}
