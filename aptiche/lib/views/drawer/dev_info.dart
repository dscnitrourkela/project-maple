import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/third_party_services.dart';
import '../../utils/theme.dart';
import '../../utils/ui_scaling.dart';

const String aboutText =
    'Google Developer Student Clubs (GDSC) is a Google Developers powered program for university students to learn mobile and web development skills. The clubs will be open to any student interested to learn, ranging from novice developers who are just starting, to advanced developers who want to further their skills. The clubs are intended as a space for students to try out new ideas and collaborate to solve mobile and web development problems.\n\n'
    'GDSC NIT Rourkela is a student chapter of GDSC India with a motive to nurture developers within the community and solve real-life problems in the community through technology.';

class DevInfo extends StatelessWidget {
  final ThirdPartyServices _thirdPartyServices = Get.find();
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
            'Developer Info',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: SizeConfig.safeBlockHorizontal! * 7,
                  color: kTextColourBlue,
                  fontWeight: FontWeight.w600,
                ),
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
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
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
                  aboutText,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: SizeConfig.safeBlockHorizontal! * 4,
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Center(
                  child: Text(
                    'DEVELOPERS',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: SizeConfig.safeBlockHorizontal! * 5.675,
                        fontWeight: FontWeight.w500,
                        color: kTextColourBlue),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  contactCard(
                    context,
                    'Abhibhaw Asthana',
                    'https://github.com/abhibhaw',
                  ),
                  contactCard(
                    context,
                    'Astha Nayak',
                    'https://github.com/nayakastha',
                  ),
                  contactCard(
                    context,
                    'Patibanda Sriram ',
                    'https://github.com/SriramPatibanda',
                  ),
                  contactCard(
                    context,
                    'Pritish Samal ',
                    'https://github.com/riteshsp2000',
                  ),
                  contactCard(
                    context,
                    'Ritesh Patil ',
                    'https://github.com/CIPHERTron',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget contactCard(BuildContext context, String name, String contact) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          if (contact != "") {
            _thirdPartyServices.urlLauncher(contact);
          } else {}
        },
        child: Card(
          elevation: 5.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: SizeConfig.safeBlockHorizontal! * 5,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
                Text(
                  contact,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: SizeConfig.safeBlockHorizontal! * 4,
                      fontWeight: FontWeight.w400,
                      color: kPrimaryColor),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
