import 'package:aptiche/services/graphql.dart';
import 'package:aptiche/services/net/authservice.dart';
import 'package:aptiche/services/theme_service.dart';
import 'package:aptiche/services/third_party_services.dart';
import 'package:aptiche/utils/theme.dart';
import 'package:aptiche/utils/ui_scaling.dart';
import 'package:aptiche/views/drawer/aiche.dart';
import 'package:aptiche/views/drawer/aichenitr.dart';
import 'package:aptiche/views/drawer/dev_info.dart';
import 'package:aptiche/views/drawer/privacy_policy.dart';
import 'package:aptiche/views/drawer/profile_page.dart';
import 'package:aptiche/views/splashscreen/user_controller.dart';
import 'package:aptiche/widgets/HomeScreen/drawer_list_tile.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_text_drawable/flutter_text_drawable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class MainDrawer extends StatelessWidget {
  MainDrawer({Key? key}) : super(key: key);
  final AuthService _authService = Get.find();
  final GraphQLService _graphQLService = Get.find();
  final ThirdPartyServices _thirdPartyServices = Get.find();
  final UserController _userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context),
      child: Drawer(
        elevation: 20.0,
        child: SafeArea(
          child: ListView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              ListTile(
                leading: SizedBox(
                    child: TextDrawable(
                  text: _userController.name.value,
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
                )),
                title: Text(
                  _userController.name.value,
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
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 12,
                            fontFamily: kPoppins,
                            fontWeight: FontWeight.normal,
                            color: Theme.of(context)
                                .primaryTextTheme
                                .bodyText1!
                                .color,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              final Map<String, String?>? user =
                                  await _graphQLService.getUserDatabyPhone(
                                      phoneNo: FirebaseAuth
                                          .instance.currentUser?.phoneNumber);
                              await Get.to<ProfilePage>(
                                () => ProfilePage(
                                  name: user!['name']!,
                                  phoneNo: user['phone']!,
                                  email: user['email']!,
                                  rollNo: user['rollNo']!,
                                ),
                              );
                            }),
                    ],
                  ),
                ),
              ),
              DrawerListTile(
                text: 'About AIChE',
                function: () {
                  Get.to<AboutAICHE>(const AboutAICHE());
                },
              ),
              DrawerListTile(
                text: 'About AIChE NITR',
                function: () {
                  Get.to<AboutAICHENITR>(const AboutAICHENITR());
                },
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
              Obx(() => Padding(
                    padding: EdgeInsets.only(
                      left: SizeConfig.safeBlockHorizontal!,
                      bottom: SizeConfig.safeBlockVertical!,
                    ),
                    child: ListTile(
                      title: Text(
                        Get.find<ThemeService>().isDarkMode.value
                            ? 'Dark Mode'
                            : 'Light Mode',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .headline2!
                            .copyWith(
                              fontSize: SizeConfig.safeBlockHorizontal! * 4.5,
                            ),
                      ),
                      contentPadding: const EdgeInsets.only(left: 16.0),
                      trailing: Transform.scale(
                        scale: 0.6,
                        child: DayNightSwitcher(
                          isDarkModeEnabled:
                              Get.find<ThemeService>().isDarkMode.value,
                          onStateChanged: (bool val) {
                            Get.find<ThemeService>().switchTheme();
                          },
                        ),
                      ),
                    ),
                  )),
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
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: SizeConfig.safeBlockHorizontal! * 5,
                    top: SizeConfig.safeBlockVertical! * 3.25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Follow us on:',
                      style: Theme.of(context)
                          .primaryTextTheme
                          .headline2!
                          .copyWith(
                            fontFamily: kPoppins,
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.safeBlockHorizontal! * 5,
                          ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          'AIChE NITR',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .headline2!
                              .copyWith(
                                  fontWeight: FontWeight.normal,
                                  fontSize:
                                      SizeConfig.safeBlockHorizontal! * 5),
                        ),
                        SizedBox(
                          width: SizeConfig.safeBlockHorizontal! * 4,
                        ),
                        IconButton(
                            icon: FaIcon(
                              FontAwesomeIcons.instagram,
                              color: Theme.of(context).iconTheme.color,
                            ),
                            onPressed: () {
                              _thirdPartyServices.urlLauncher(
                                  'https://www.instagram.com/aiche.nitrkl');
                            }),
                        IconButton(
                            icon: FaIcon(
                              FontAwesomeIcons.linkedin,
                              color: Theme.of(context).iconTheme.color,
                            ),
                            onPressed: () {
                              _thirdPartyServices.urlLauncher(
                                  'https://www.linkedin.com/company/aiche-nitr');
                            }),
                        IconButton(
                            icon: FaIcon(
                              FontAwesomeIcons.facebook,
                              color: Theme.of(context).iconTheme.color,
                            ),
                            onPressed: () {
                              _thirdPartyServices.urlLauncher(
                                  'https://www.facebook.com/AIChENITR');
                            }),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          'GDSC NITR',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .headline2!
                              .copyWith(
                                  fontWeight: FontWeight.normal,
                                  fontSize:
                                      SizeConfig.safeBlockHorizontal! * 5),
                        ),
                        SizedBox(
                          width: SizeConfig.safeBlockHorizontal! * 4,
                        ),
                        IconButton(
                            icon: FaIcon(
                              FontAwesomeIcons.globe,
                              color: Theme.of(context).iconTheme.color,
                            ),
                            onPressed: () {
                              _thirdPartyServices.urlLauncher(
                                'https://dscnitrourkela.org',
                              );
                            }),
                        IconButton(
                            icon: FaIcon(FontAwesomeIcons.instagram,
                                color: Theme.of(context).iconTheme.color),
                            onPressed: () {
                              _thirdPartyServices.urlLauncher(
                                  'https://www.instagram.com/dscnitrourkela');
                            }),
                        IconButton(
                            icon: FaIcon(
                              FontAwesomeIcons.github,
                              color: Theme.of(context).iconTheme.color,
                            ),
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
      ),
    );
  }
}
