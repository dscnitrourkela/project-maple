import 'package:aptiche/services/graphql.dart';
import 'package:aptiche/services/net/authservice.dart';
import 'package:aptiche/views/dataentry/dataentry.dart';
import 'package:aptiche/views/home/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserCheck {
  final AuthService _authService = Get.find();
  final GraphQLService _graphQLService = Get.find();

  Future<Widget> checkUserData() async {
    final String result = await checkUser();
    if (result != 'null') {
      return const HomeScreen();
    } else {
      return const DataEntryScreen();
    }
  }

  Future<String> checkUser() async {
    final String result = await _graphQLService
        .checkUserbyPhone(_authService.getCurrentUserPhone().toString());
    return result;
  }
}
