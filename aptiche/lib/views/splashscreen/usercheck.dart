import 'package:aptiche/services/graphql.dart';
import 'package:aptiche/services/net/authservice.dart';
import 'package:aptiche/views/dataentry/dataentry.dart';
import 'package:aptiche/views/home/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserCheck extends StatelessWidget {
  UserCheck({Key? key}) : super(key: key);

  final AuthService _authService = Get.find();
  final GraphQLService _graphQLService = Get.find();

  @override
  Widget build(BuildContext context) {
    return _graphQLService.checkUserbyPhone(
                _authService.getCurrentUserPhone().toString()) !=
            null
        ? const HomeScreen()
        : const DataEntryScreen();
  }
}
