import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DataEntryController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController rollNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final String? phoneNo = FirebaseAuth.instance.currentUser?.phoneNumber;
  final String? authId = FirebaseAuth.instance.currentUser?.uid;
  final GetStorage localUserStorage = GetStorage('User');
  String? token;

  Future<String?> getFCMToken() async {
    await FirebaseMessaging.instance.getToken();
  }

  void writeUser() async {
    token = await getFCMToken();
    localUserStorage.write('name', nameController.text);
    localUserStorage.write('rollNo', rollNoController.text);
    localUserStorage.write('email', emailController.text);
    localUserStorage.write('phoneNo', phoneNo);
  }

  void readUser() {
    nameController.text = localUserStorage.read<String?>('name').toString();
    rollNoController.text = localUserStorage.read<String?>('rollNo').toString();
    emailController.text = localUserStorage.read<String?>('email').toString();
  }
}
