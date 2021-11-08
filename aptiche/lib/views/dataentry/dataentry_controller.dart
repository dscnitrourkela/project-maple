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
  List<String?> fcmtoken = <String?>[];
  String? docId;
  String? jwttoken;

  void writeUser(String name, String rollNo, String email, String phone) async {
    debugPrint('write-user start');
    if (FirebaseAuth.instance.currentUser != null) {
      final String jwttoken =
          await FirebaseAuth.instance.currentUser!.getIdToken(true);
      await _graphQLService.initGraphQL(jwttoken);
    }

    fcmtoken.add(await FirebaseMessaging.instance.getToken());
    docId = await _graphQLService.createUsers(
      fcmTokens: fcmtoken,
      name: name,
      rollNo: rollNo,
      email: email,
      phoneNo: phone,
      quizzes: <String?>[],
    );

    await localUserStorage.write('name', name);
    await localUserStorage.write('email', email);
    await localUserStorage.write('phoneNo', phone);
    await localUserStorage.write('rollNo', rollNo);
    await localUserStorage.write('dbID', docId);
    debugPrint(localUserStorage.read('rollNo'));
    debugPrint('docId: $docId');
  }

  Future<String?> readUser() async {
    if (FirebaseAuth.instance.currentUser != null) {
      jwttoken = await FirebaseAuth.instance.currentUser!.getIdToken(true);
    }
    return jwttoken;
  }
}
