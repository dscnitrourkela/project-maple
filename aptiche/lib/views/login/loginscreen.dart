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
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfff6f6f6),
      body: SafeArea(
        child: Stack(
          fit: StackFit.loose,
          children: <Widget>[
            Positioned(
              bottom: SizeConfig.screenHeight! * 0.5,
              left: SizeConfig.screenWidth! * 0.175,
              right: SizeConfig.screenWidth! * 0.175,
              child: SvgPicture.asset(
                loginScreenSVG,
                alignment: Alignment.center,
                placeholderBuilder: (BuildContext context) => Container(
                    padding: const EdgeInsets.all(30.0),
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator()),
                height: SizeConfig.screenHeight! * 0.32,
              ),
            ),
            Positioned(
              top: SizeConfig.screenHeight! * 0.6,
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
                                'Enter the OTP sent to your mobile',
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
                            children: <Widget>[
                              CustomTextField(
                                editingController:
                                    controller.phoneEditController,
                                validator: !controller.sent.value
                                    ? (dynamic value) {
                                        return Validator.validatePhoneNo(
                                          controller.phoneEditController.text,
                                        );
                                      }
                                    : null,
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
                        padding: EdgeInsets.only(
                          top: SizeConfig.safeBlockVertical! * 4,
                        ),
                        width: SizeConfig.screenWidth,
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomButton(
                              text: !controller.sent.value ? 'LOGIN' : 'VERIFY',
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
                                        Get.snackbar<dynamic>(
                                          '',
                                          'Something went wrong. Please try again',
                                        );
                                      } else {
                                        Get.to<dynamic>(
                                            () => const DataEntryScreen());
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
            )
          ],
        ),
      ),
    );
  }
}
