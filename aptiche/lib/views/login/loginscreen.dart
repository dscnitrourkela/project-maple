import 'package:aptiche/utils/string.dart';
import 'package:aptiche/utils/theme.dart';
import 'package:aptiche/utils/ui_scaling.dart';
import 'package:aptiche/utils/validator.dart';
import 'package:aptiche/views/data%20entry/dataentry.dart';
import 'package:aptiche/views/login/logincontroller.dart';
import 'package:aptiche/widgets/buttons.dart';
import 'package:aptiche/widgets/textfeilds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  final authService = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xfff6f6f6),
      body: SafeArea(
        child: Stack(
          fit: StackFit.loose,
          children: [
            Positioned(
              bottom: SizeConfig.screenHeight * 0.6,
              left: SizeConfig.screenWidth * 0.175,
              child: SvgPicture.asset(
                loginScreenSVG,
                alignment: Alignment.center,
                height: SizeConfig.screenHeight * 0.32,
              ),
            ),
            Positioned(
              top: SizeConfig.screenHeight * 0.4,
              child: Container(
                height: SizeConfig.screenHeight * 0.6,
                padding: EdgeInsets.only(
                  top: SizeConfig.safeBlockVertical * 4,
                ),
                decoration: BoxDecoration(
                  color: kBgColour,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      SizeConfig.safeBlockHorizontal * 10,
                    ),
                    topRight: Radius.circular(
                      SizeConfig.safeBlockHorizontal * 10,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        left: SizeConfig.safeBlockHorizontal * 6,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Hey, Welcome!',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).primaryTextTheme.headline1,
                      ),
                    ),
                    Form(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.safeBlockHorizontal * 6,
                            vertical: SizeConfig.safeBlockHorizontal * 2),
                        child: Column(
                          children: [
                            textField(
                              LoginController().phoneEditController,
                              Validator.validatePhoneNo(
                                LoginController().phoneEditController.text,
                              ),
                              "Enter Mobile Number",
                              "+9193481xxx60",
                              TextInputType.phone,
                              Icons.call,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: SizeConfig.safeBlockVertical * 4),
                      width: SizeConfig.screenWidth,
                      alignment: Alignment.center,
                      child: button("LOGIN", () {
                        print(LoginController().phoneEditController.text);
                        Get.to(() => DataEntryScreen());
                      }),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
