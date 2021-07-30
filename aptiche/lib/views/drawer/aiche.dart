import 'package:aptiche/utils/theme.dart';
import 'package:aptiche/utils/ui_scaling.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutAICHE extends StatelessWidget {
  const AboutAICHE({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColour,
      appBar: AppBar(
          elevation: 6,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            color: kTextColourBlue,
            onPressed: () {
              Get.back<dynamic>();
            },
          ),
          centerTitle: false,
          backgroundColor: kBgColour,
          title: Text(
            'AIChE',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: SizeConfig.safeBlockHorizontal! * 7,
                  color: kTextColourBlue,
                  fontWeight: FontWeight.w600,
                ),
          )),
    );
  }
}
