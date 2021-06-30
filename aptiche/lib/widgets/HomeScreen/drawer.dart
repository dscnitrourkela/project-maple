import 'package:aptiche/services/net/authservice.dart';
import 'package:aptiche/services/third_party_services.dart';
import 'package:aptiche/utils/theme.dart';
import 'package:aptiche/utils/ui_scaling.dart';
import 'package:aptiche/widgets/HomeScreen/drawer_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HomeScreenDrawer extends StatelessWidget {
  HomeScreenDrawer({
    Key? key,
    required AuthService authService,
  })  : _authService = authService,
        super(key: key);

  final AuthService _authService;

  final ThirdPartyServices _thirdPartyServices = Get.find();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: SizeConfig.screenHeight! * 0.30,
            child: DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      size: SizeConfig.safeBlockHorizontal! * 10,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 3,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Swagat Subhakanta Das',
                      style: Theme.of(context)
                          .primaryTextTheme
                          .headline2!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      '119CH0063 \n +917749914583 \n dasswagat142@gmail.com',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .primaryTextTheme
                          .bodyText2!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const DrawerListTile(text: 'About AIChE'),
          const DrawerListTile(text: 'About AIChE NITR'),
          const DrawerListTile(text: 'Privacy Policy'),
          const DrawerListTile(text: 'Developers Info'),
          SizedBox(height: SizeConfig.safeBlockVertical! * 4),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.safeBlockHorizontal! * 10,
            ),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).buttonColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              onPressed: () => _authService.signOut(),
              child: Text(
                'Log Out',
                style: Theme.of(context)
                    .primaryTextTheme
                    .headline2!
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical! * 4,
          ),
          Padding(
            padding: EdgeInsets.only(left: SizeConfig.safeBlockHorizontal! * 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Follow us on:',
                  style: Theme.of(context).primaryTextTheme.headline2!.copyWith(
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
                      'DSC NITR   ',
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
                          _thirdPartyServices
                              .urlLauncher('https://github.com/dscnitrourkela');
                        }),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
