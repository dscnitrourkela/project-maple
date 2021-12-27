import 'package:aptiche/utils/string.dart';
import 'package:aptiche/widgets/HomeScreen/contact_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/third_party_services.dart';
import '../../utils/theme.dart';
import '../../utils/ui_scaling.dart';

class DevInfo extends StatelessWidget {
  DevInfo({
    Key? key,
  }) : super(key: key);
  final ThirdPartyServices _thirdPartyServices = Get.find();
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
            'Developer Info',
            style: Theme.of(context).primaryTextTheme.headline2,
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal! * 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.safeBlockHorizontal! * 4),
                child: Text(
                  'ABOUT',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).primaryTextTheme.bodyText1!.copyWith(
                        fontSize: SizeConfig.safeBlockHorizontal! * 6,
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.safeBlockHorizontal! * 4,
                    vertical: SizeConfig.safeBlockHorizontal! * 4),
                child: Text(
                  Strings.aboutText,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).primaryTextTheme.bodyText1!.copyWith(
                        fontSize: SizeConfig.safeBlockHorizontal! * 4,
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                child: Image.asset(
                  'assets/images/gdsc.png',
                  fit: BoxFit.contain,
                  width: SizeConfig.screenWidth! * 0.3,
                  height: SizeConfig.screenWidth! * 0.3,
                  alignment: Alignment.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Center(
                  child: Text(
                    'DEVELOPERS',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .headline3!
                        .copyWith(
                            fontSize: SizeConfig.safeBlockHorizontal! * 5.675,
                            fontWeight: FontWeight.w500,
                            color: kTextColourBlue),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ContactCard(
                    context: context,
                    thirdPartyServices: _thirdPartyServices,
                    name: 'Abhibhaw Asthana',
                    contact: 'https://github.com/abhibhaw',
                  ),
                  ContactCard(
                    context: context,
                    thirdPartyServices: _thirdPartyServices,
                    name: 'Astha Nayak',
                    contact: 'https://github.com/nayakastha',
                  ),
                  ContactCard(
                    context: context,
                    thirdPartyServices: _thirdPartyServices,
                    name: 'Patibanda Sriram ',
                    contact: 'https://github.com/SriramPatibanda',
                  ),
                  ContactCard(
                    context: context,
                    thirdPartyServices: _thirdPartyServices,
                    name: 'Ritesh Patil ',
                    contact: 'https://github.com/riteshsp2000',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
