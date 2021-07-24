import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ThirdPartyServices extends GetxController {
  Future<void> urlLauncher(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
