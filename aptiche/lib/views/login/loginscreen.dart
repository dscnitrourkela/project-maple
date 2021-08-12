import 'package:aptiche/utils/string.dart';
import 'package:aptiche/utils/theme.dart';
import 'package:aptiche/utils/ui_scaling.dart';
import 'package:aptiche/views/login/logincontroller.dart';
import 'package:aptiche/widgets/buttons.dart';
import 'package:aptiche/widgets/textfeilds.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: kGreyBgColor,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: SizeConfig.screenHeight! * 0.0000001,
              height: SizeConfig.screenHeight! * 0.35,
              child: Container(
                height: SizeConfig.screenHeight! * 0.4,
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
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                          left: SizeConfig.safeBlockHorizontal! * 6,
                        ),
                        alignment: Alignment.centerLeft,
                        child: !controller.sent.value
                            ? Text(
                                'Hey, Welcome!',
                                textAlign: TextAlign.left,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .headline1,
                              )
                            : Text(
                                'Verification',
                                textAlign: TextAlign.left,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .headline1,
                              ),
                      ),
                      Form(
                        key: controller.formkey,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.safeBlockHorizontal! * 6,
                              vertical: SizeConfig.safeBlockHorizontal! * 2),
                          child: Column(
                            children: <Widget>[
                              CustomTextField(
                                editingController:
                                    controller.phoneEditController,
                                validator: !controller.sent.value
                                    ? (String? value) {
                                        if ((value!.length == 13 ||
                                                value.length == 14) &&
                                            value[0] == '+') {
                                          return null;
                                        } else
                                          return 'Enter a valid mobile number';
                                      }
                                    : (String? value) {
                                        if (value!.length != 6) {
                                          return 'Enter the 6-digit OTP sent';
                                        } else
                                          return null;
                                      },
                                label: !controller.sent.value
                                    ? 'Enter Mobile Number'
                                    : 'Enter OTP',
                                hint: !controller.sent.value
                                    ? '+9193481xxx60'
                                    : '6 digit OTP',
                                type: TextInputType.phone,
                                icon: !controller.sent.value
                                    ? Icons.call
                                    : Icons.sms,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: SizeConfig.screenWidth,
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            if (controller.loading.value == true)
                              const CircularProgressIndicator(
                                backgroundColor: kPrimaryColor,
                              )
                            else
                              CustomButton(
                                horizontalPadding:
                                    SizeConfig.safeBlockHorizontal! * 3.5,
                                verticalPadding:
                                    SizeConfig.safeBlockVertical! * 0.27,
                                text:
                                    !controller.sent.value ? 'LOGIN' : 'VERIFY',
                                onTap: !controller.sent.value
                                    ? () {
                                        if (controller.formkey.currentState!
                                            .validate()) {
                                          controller.phoneNo.value = controller
                                              .phoneEditController.text
                                              .trim();
                                          controller.verifyPhone();
                                          controller.sent.toggle();
                                          controller.loading.value = true;
                                        }
                                        controller.phoneEditController.clear();
                                      }
                                    : () {
                                        if (controller.formkey.currentState!
                                            .validate()) {
                                          controller.smsCode.value = controller
                                              .phoneEditController.text
                                              .trim();
                                          controller.loading.value = true;
                                          controller.createUser();
                                        }
                                      },
                              ),
                            if (controller.sent.value)
                              Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      SizeConfig.safeBlockHorizontal! * 12,
                                  vertical: SizeConfig.safeBlockVertical! * 1,
                                ),
                                child: RichText(
                                  text: TextSpan(
                                    text: 'wrong mobile number?',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText1,
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: ' CHANGE',
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .bodyText2!
                                              .copyWith(color: Colors.blue),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              controller.sent.toggle();
                                              controller.loading.toggle();
                                              controller.phoneEditController
                                                  .clear();
                                            }),
                                    ],
                                  ),
                                ),
                              )
                            else
                              Container(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: SizeConfig.screenHeight! * 0.375,
              left: SizeConfig.screenWidth! * 0.175,
              right: SizeConfig.screenWidth! * 0.175,
              child: SvgPicture.asset(
                Strings.loginScreenSVG,
                alignment: Alignment.center,
                placeholderBuilder: (BuildContext context) => Container(
                    padding: const EdgeInsets.all(30.0),
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(
                      backgroundColor: kPrimaryColor,
                    )),
                height: SizeConfig.screenHeight! * 0.32,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
