import 'package:aptiche/net/authservice.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    //AuthService().signOut();
    return Scaffold(
      body: Center(
        child: Text(name),
      ),
    );
  }
}
