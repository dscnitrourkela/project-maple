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
import 'package:flutter/gestures.dart';
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
                        child: !loginController.sent.value
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
                                validator: !loginController.sent.value
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
                                hint: !loginController.sent.value
                                    ? "+9193481xxx60"
                                    : "6 digit OTP",
                                type: TextInputType.phone,
                                icon: !loginController.sent.value
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
                          text:
                              !loginController.sent.value ? "LOGIN" : "Verify",
                          onTap: !loginController.sent.value
                              ? () {
                                  if (loginController.formkey.currentState!
                                      .validate()) {
                                    loginController.phoneNo.value =
                                        loginController
                                            .phoneEditController.text;
                                    loginController.verifyPhone();
                                    loginController.sent.toggle();
                                  }
                                  loginController.phoneEditController.clear();
                                }
                              : () {
                                  _authService.signInwithOTP(
                                    loginController.phoneEditController.text,
                                    loginController.verificationId,
                                  );
                                  debugPrint(
                                      'status: ${loginController.status.value}');
                                  if (loginController.status.value ==
                                      'Something has gone wrong, please try later') {
                                    Get.snackbar(
                                      '',
                                      loginController.status.value,
                                    );
                                  } else {
                                    Get.to(() => DataEntryScreen());
                                  }
                                },
                        ),
                      ),
                      loginController.sent.value
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    SizeConfig.safeBlockHorizontal! * 12,
                                vertical: SizeConfig.safeBlockVertical! * 12,
                              ),
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: 'Wrong Phone no?',
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyText1,
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: ' Use a different phone number',
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyText1!
                                            .copyWith(color: Colors.blue),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            loginController.sent.toggle();
                                            loginController.phoneEditController
                                                .clear();
                                          }),
                                  ],
                                ),
                              ),
                            )
                          : Container(),
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
