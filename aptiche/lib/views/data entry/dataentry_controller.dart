import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DataEntryController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController rollNoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
}
