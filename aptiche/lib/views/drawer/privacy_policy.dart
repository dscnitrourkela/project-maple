import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';

import '../../utils/theme.dart';
import '../../utils/ui_scaling.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

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
            'Privacy Policy',
            style: Theme.of(context).primaryTextTheme.headline2,
          )),
      body: SingleChildScrollView(
        child: FutureBuilder<String>(
          future: rootBundle.loadString('assets/markdown/privacy_policy.md'),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.safeBlockHorizontal! * 4,
                    vertical: SizeConfig.safeBlockHorizontal! * 4),
                child: SizedBox(
                    height: SizeConfig.screenHeight! * 0.9,
                    child: MarkDownRender(privacypolicy: snapshot.data!)),
              );
            } else {
              return SizedBox(
                  height: SizeConfig.screenWidth! * 0.1,
                  child: const CircularProgressIndicator(
                    backgroundColor: kPrimaryColor,
                  ));
            }
          },
        ),
      ),
    );
  }
}

class MarkDownRender extends StatelessWidget {
  const MarkDownRender({Key? key, required this.privacypolicy})
      : super(key: key);

  final String privacypolicy;

  @override
  Widget build(BuildContext context) {
    return Markdown(
      styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context))
          .copyWith(p: Theme.of(context).primaryTextTheme.bodyText1),
      data: privacypolicy,
      selectable: true,
    );
  }
}
