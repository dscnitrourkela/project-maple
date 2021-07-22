import 'package:aptiche/services/graphql.dart';
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
  final GraphQLService _graphQLService = Get.find();
  final String? phoneNo = FirebaseAuth.instance.currentUser?.phoneNumber;
  final String? authId = FirebaseAuth.instance.currentUser?.uid;
  final GetStorage localUserStorage = GetStorage('User');
  String? fcmtoken;
  String? docId;
  String? jwttoken;

  Future<String?> getFCMToken() async {
    await FirebaseMessaging.instance.getToken();
  }

  void writeUser() async {
    print("write-user start");
    await _graphQLService.initGraphQL(jwttoken);
    fcmtoken = await getFCMToken();
    docId = await _graphQLService.createUsers(
      authId,
      fcmtoken,
      nameController.text,
      emailController.text,
      phoneNo,
      rollNoController.text,
      <String>[],
    );
    debugPrint('$fcmtoken $docId');
    localUserStorage.write('name', nameController.text);
    localUserStorage.write('rollNo', rollNoController.text);
    localUserStorage.write('email', emailController.text);
    localUserStorage.write('phoneNo', phoneNo);
    localUserStorage.write('dbID', docId);
  }

  void readUser() async {
    if (FirebaseAuth.instance.currentUser != null) {
      jwttoken = await FirebaseAuth.instance.currentUser!.getIdToken(true);
    }

    nameController.text = localUserStorage.read<String?>('name').toString();
    rollNoController.text = localUserStorage.read<String?>('rollNo').toString();
    emailController.text = localUserStorage.read<String?>('email').toString();
  }
}
