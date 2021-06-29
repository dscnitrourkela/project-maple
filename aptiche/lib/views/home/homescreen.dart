import 'package:aptiche/net/authservice.dart';
import 'package:aptiche/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService _authService = Get.find();
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: kPrimaryColor),
            onPressed: () {
              _authService.signOut();
            },
            child: const Text('Log out')),
      ),
    );
  }
}
