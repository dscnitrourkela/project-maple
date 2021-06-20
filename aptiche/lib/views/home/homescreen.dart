import 'package:aptiche/net/authservice.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthService().signOut();
    return const Scaffold(
      body: Center(
        child: Text('log out'),
      ),
    );
  }
}
