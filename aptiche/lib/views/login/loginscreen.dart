import 'package:aptiche/utils/string.dart';
import 'package:aptiche/utils/theme.dart';
import 'package:aptiche/utils/ui_scaling.dart';
import 'package:aptiche/utils/validator.dart';
import 'package:aptiche/views/data%20entry/dataentry.dart';
import 'package:aptiche/views/login/logincontroller.dart';
import 'package:aptiche/widgets/buttons.dart';
import 'package:aptiche/widgets/textfeilds.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LoginView extends GetView<LoginController> {
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
                        child: !controller.sent.value
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
                        key: controller.formkey,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.safeBlockHorizontal! * 6,
                              vertical: SizeConfig.safeBlockHorizontal! * 2),
                          child: Column(
                            children: [
                              CustomTextField(
                                editingController:
                                    controller.phoneEditController,
                                validator: !controller.sent.value
                                    ? (value) {
                                        return Validator.validatePhoneNo(
                                          controller.phoneEditController.text,
                                        );
                                      }
                                    : null,
                                label: !controller.sent.value
                                    ? "Enter Mobile Number"
                                    : "Enter OTP",
                                hint: !controller.sent.value
                                    ? "+9193481xxx60"
                                    : "6 digit OTP",
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
                        padding: EdgeInsets.only(
                          top: SizeConfig.safeBlockVertical! * 4,
                        ),
                        width: SizeConfig.screenWidth!,
                        alignment: Alignment.center,
                        child: CustomButton(
                          text: !controller.sent.value ? "LOGIN" : "Verify",
                          onTap: !controller.sent.value
                              ? () {
                                  if (controller.formkey.currentState!
                                      .validate()) {
                                    controller.phoneNo.value =
                                        controller.phoneEditController.text;
                                    controller.verifyPhone();
                                    controller.sent.toggle();
                                  }
                                  controller.phoneEditController.clear();
                                  debugPrint(
                                      'status1: ${controller.status.value}');
                                }
                              : () {
                                  controller.smsCode.value =
                                      controller.phoneEditController.text;
                                  controller.createUser();
                                  if (!controller.status.value) {
                                    Get.snackbar(
                                      '',
                                      'Something went wrong. Please try again',
                                    );
                                  } else {
                                    Get.to(() => DataEntryScreen());
                                  }
                                },
                        ),
                      ),
                      controller.sent.value
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
                                            controller.sent.toggle();
                                            controller.phoneEditController
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
