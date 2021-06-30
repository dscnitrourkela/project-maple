import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ThirdPartyServices {
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
