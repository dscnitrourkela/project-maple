import 'package:aptiche/utils/string.dart';
import 'package:aptiche/utils/ui_scaling.dart';
import 'package:aptiche/utils/validator.dart';
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
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30.0,
            ),
            Center(
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: SvgPicture.asset(
                  loginScreenSVG,
                  alignment: Alignment.center,
                  height: 230.0,
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 30.0),
              alignment: Alignment.centerLeft,
              child: Text(
                'Hey, Welcome!',
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
                  )
                ],
              ),
            )),
            button("LOGIN", () {
              print("ftftyo");
              print(LoginController().phoneEditController.text);
            })
          ],
        ),
      ),
    );
  }
}
