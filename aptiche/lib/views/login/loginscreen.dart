import 'package:aptiche/net/authservice.dart';
import 'package:aptiche/utils/string.dart';
import 'package:aptiche/utils/theme.dart';
import 'package:aptiche/utils/ui_scaling.dart';
import 'package:aptiche/utils/validator.dart';
import 'package:aptiche/views/data%20entry/dataentry.dart';
import 'package:aptiche/views/login/logincontroller.dart';
import 'package:aptiche/widgets/buttons.dart';
import 'package:aptiche/widgets/textfeilds.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());
  final AuthService _authService = Get.put(AuthService());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfff6f6f6),
      body: SafeArea(
        child: Stack(
          fit: StackFit.loose,
          children: [
            Positioned(
              bottom: SizeConfig.screenHeight! * 0.6,
              left: SizeConfig.screenWidth! * 0.175,
              child: SvgPicture.asset(
                loginScreenSVG,
                alignment: Alignment.center,
                height: SizeConfig.screenHeight! * 0.32,
              ),
            ),
            Positioned(
              top: SizeConfig.screenHeight! * 0.4,
              child: Container(
                height: SizeConfig.screenHeight! * 0.6,
                padding: EdgeInsets.only(
                  top: SizeConfig.safeBlockVertical! * 4,
                ),
                decoration: BoxDecoration(
                  color: kBgColour,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      SizeConfig.safeBlockHorizontal! * 10,
                    ),
                    topRight: Radius.circular(
                      SizeConfig.safeBlockHorizontal! * 10,
                    ),
                  ),
                ),
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: SizeConfig.safeBlockHorizontal! * 6,
                        ),
                        alignment: Alignment.centerLeft,
                        child: !loginController.codeSent.value
                            ? Text(
                                'Hey, Welcome!',
                                textAlign: TextAlign.left,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .headline1,
                              )
                            : Text(
                                'Enter your OTP',
                                textAlign: TextAlign.left,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .headline2,
                              ),
                      ),
                      Form(
                        key: loginController.formkey,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.safeBlockHorizontal! * 6,
                              vertical: SizeConfig.safeBlockHorizontal! * 2),
                          child: Column(
                            children: [
                              CustomTextField(
                                editingController:
                                    loginController.phoneEditController,
                                validator: !loginController.codeSent.value
                                    ? (value) {
                                        return Validator.validatePhoneNo(
                                          loginController
                                              .phoneEditController.text,
                                        );
                                      }
                                    : null,
                                label: !loginController.sent.value
                                    ? "Enter Mobile Number"
                                    : "Enter OTP",
                                hint: !loginController.codeSent.value
                                    ? "+9193481xxx60"
                                    : "6 digit OTP",
                                type: TextInputType.phone,
                                icon: !loginController.codeSent.value
                                    ? Icons.call
                                    : Icons.sms,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          top: SizeConfig.safeBlockVertical! * 4,
                        ),
                        width: SizeConfig.screenWidth!,
                        alignment: Alignment.center,
                        child: CustomButton(
                            text: !loginController.codeSent.value
                                ? "LOGIN"
                                : "Verify",
                            onTap: !loginController.codeSent.value
                                ? () {
                                    if (loginController.formkey.currentState!
                                        .validate()) {
                                      loginController.phoneNo.value =
                                          loginController
                                              .phoneEditController.text;
                                      loginController.verifyPhone();
                                      // loginController.codeSent.toggle();
                                    }
                                    loginController.phoneEditController.clear();
                                  }
                                : () {
                                    //TODO: Handle error when the user enters a wrong otp
                                    _authService.signInwithOTPSeller(
                                      loginController.phoneEditController.text,
                                      loginController.verificationId,
                                    );
                                    Get.to(() => DataEntryScreen());
                                  }),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
