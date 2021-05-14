import 'package:aptiche/utils/string.dart';
import 'package:aptiche/utils/theme.dart';
import 'package:aptiche/utils/ui_scaling.dart';
import 'package:aptiche/utils/validator.dart';
import 'package:aptiche/views/data%20entry/dataentry_controller.dart';
import 'package:aptiche/views/login/loginscreen.dart';
import 'package:aptiche/widgets/buttons.dart';
import 'package:aptiche/widgets/textfeilds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DataEntryScreen extends StatelessWidget {
  const DataEntryScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                dataEntryScreen,
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
                        'Fill in the Information',
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
                              DataEntryController().nameController,
                              Validator.validateName(
                                DataEntryController().nameController.text,
                              ),
                              "Enter Name",
                              "John Doe",
                              TextInputType.name,
                              Icons.person,
                            ),
                            textField(
                              DataEntryController().rollNoController,
                              Validator.validateRoll(
                                DataEntryController().rollNoController.text,
                              ),
                              "Enter Roll Number",
                              "118CH001",
                              TextInputType.text,
                              Icons.school_rounded,
                            ),
                            textField(
                              DataEntryController().emailController,
                              Validator.validateEmail(
                                DataEntryController().emailController.text,
                              ),
                              "Enter Roll Number",
                              "118CH001",
                              TextInputType.text,
                              Icons.person,
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
                      child: button("PROCEED", () {
                        Get.to(() => LoginView());
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
