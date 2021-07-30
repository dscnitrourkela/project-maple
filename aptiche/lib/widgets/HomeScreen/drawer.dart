import 'package:aptiche/services/net/authservice.dart';
import 'package:aptiche/services/third_party_services.dart';
import 'package:aptiche/utils/theme.dart';
import 'package:aptiche/utils/ui_scaling.dart';
import 'package:aptiche/views/drawer/dev_info.dart';
import 'package:aptiche/views/drawer/privacy_policy.dart';
import 'package:aptiche/widgets/HomeScreen/drawer_list_tile.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_text_drawable/flutter_text_drawable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MainDrawer extends StatelessWidget {
  MainDrawer({Key? key}) : super(key: key);
  final AuthService _authService = Get.find();
  final ThirdPartyServices _thirdPartyServices = Get.find();

  final GetStorage localUserStorage = GetStorage('User');
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 20.0,
      child: SafeArea(
        child: ListView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            ListTile(
              leading: SizedBox(
                child: TextDrawable(
                  text: localUserStorage.read<String?>('name').toString(),
                  height: SizeConfig.safeBlockHorizontal! * 25,
                  width: SizeConfig.safeBlockHorizontal! * 15,
                  textStyle: const TextStyle(
                    fontSize: 32,
                    fontFamily: kSfpro,
                    fontWeight: FontWeight.w700,
                    color: kBgColour,
                  ),
                  backgroundColor: kTextColourBlue,
                  boxShape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              title: Text(
                localUserStorage.read<String?>('name').toString(),
                textAlign: TextAlign.left,
                maxLines: 3,
                softWrap: true,
                style: Theme.of(context).primaryTextTheme.headline2,
              ),
              subtitle: RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: 'View Profile',
                        style: Theme.of(context).primaryTextTheme.bodyText2,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            debugPrint('There is no profile page');
                          }),
                  ],
                ),
              ),
            ),
            DrawerListTile(
              text: 'About AIChE',
              function: () {},
            ),
            DrawerListTile(
              text: 'About AIChE NITR',
              function: () {},
            ),
            DrawerListTile(
              text: 'Privacy Policy',
              function: () {
                Get.to<PrivacyPolicyPage>(const PrivacyPolicyPage());
              },
            ),
            DrawerListTile(
              text: 'Developers Info',
              function: () {
                Get.to<DevInfo>(DevInfo());
              },
            ),
            Container(
              alignment: Alignment.centerLeft,
              width: SizeConfig.safeBlockHorizontal! * 7.5,
              padding: EdgeInsets.only(
                left: SizeConfig.safeBlockHorizontal! * 2.5,
              ),
              child: ElevatedButton(
                onPressed: () {
                  _authService.signOut();
                },
                style: ElevatedButton.styleFrom(
                  primary: kTextColourBlue.withOpacity(0.8),
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.safeBlockHorizontal! * 5,
                    vertical: SizeConfig.safeBlockHorizontal! * 2,
                  ),
                  elevation: SizeConfig.safeBlockHorizontal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      SizeConfig.safeBlockVertical! * 2.125,
                    ),
                  ),
                ),
                child: Text(
                  'LOG OUT',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kTextColourWhite,
                    fontFamily: kSfpro,
                    fontSize: SizeConfig.safeBlockVertical! * 2.625,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: SizeConfig.safeBlockHorizontal! * 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Follow us on:',
                    style:
                        Theme.of(context).primaryTextTheme.headline2!.copyWith(
                              fontFamily: kPoppins,
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.safeBlockHorizontal! * 5,
                            ),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'AIChE NITR',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .bodyText1!
                            .copyWith(
                                fontSize: SizeConfig.safeBlockHorizontal! * 5),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      IconButton(
                          icon: const FaIcon(FontAwesomeIcons.instagram),
                          onPressed: () {
                            _thirdPartyServices.urlLauncher(
                                'https://www.instagram.com/aiche.nitrkl');
                          }),
                      IconButton(
                          icon: const FaIcon(FontAwesomeIcons.linkedin),
                          onPressed: () {
                            _thirdPartyServices.urlLauncher(
                                'https://www.linkedin.com/company/aiche-nitr');
                          }),
                      IconButton(
                          icon: const FaIcon(FontAwesomeIcons.facebook),
                          onPressed: () {
                            _thirdPartyServices.urlLauncher(
                                'https://www.facebook.com/AIChENITR');
                          }),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'GDSC NITR   ',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .bodyText1!
                            .copyWith(
                                fontSize: SizeConfig.safeBlockHorizontal! * 5),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      IconButton(
                          icon: const FaIcon(FontAwesomeIcons.globe),
                          onPressed: () {
                            _thirdPartyServices
                                .urlLauncher('https://dscnitrourkela.org');
                          }),
                      IconButton(
                          icon: const FaIcon(FontAwesomeIcons.instagram),
                          onPressed: () {
                            _thirdPartyServices.urlLauncher(
                                'https://www.instagram.com/dscnitrourkela');
                          }),
                      IconButton(
                          icon: const FaIcon(FontAwesomeIcons.github),
                          onPressed: () {
                            _thirdPartyServices.urlLauncher(
                                'https://github.com/dscnitrourkela');
                          }),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
