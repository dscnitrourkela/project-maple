import 'package:aptiche/utils/string.dart';
import 'package:aptiche/utils/ui_scaling.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutAICHE extends StatelessWidget {
  const AboutAICHE({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: kBgColour,
      appBar: AppBar(
          elevation: 6,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            // color: kTextColourBlue,
            onPressed: () {
              Get.back<dynamic>();
            },
          ),
          centerTitle: false,
          // backgroundColor: kBgColour,
          title: Text(
            'AIChE',
            style: Theme.of(context).primaryTextTheme.headline2!.copyWith(
                  fontSize: SizeConfig.safeBlockHorizontal! * 7,
                  // color: kTextColourBlue,
                  fontWeight: FontWeight.w600,
                ),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal! * 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal! * 3),
                width: SizeConfig.screenWidth! * 0.7,
                child: Image.asset(
                  'assets/images/aiche.png',
                  color: Theme.of(context).backgroundColor == Colors.black
                      ? Colors.white
                      : null,
                  alignment: Alignment.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.safeBlockHorizontal! * 4,
                    vertical: SizeConfig.safeBlockHorizontal! * 4),
                child: Text(
                  Strings.aiche,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).primaryTextTheme.bodyText1!.copyWith(
                        fontSize: SizeConfig.safeBlockHorizontal! * 4.5,
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
