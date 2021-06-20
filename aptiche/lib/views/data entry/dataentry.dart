import 'package:aptiche/utils/string.dart';
import 'package:aptiche/utils/theme.dart';
import 'package:aptiche/utils/ui_scaling.dart';
import 'package:aptiche/utils/validator.dart';
import 'package:aptiche/views/data%20entry/dataentry_controller.dart';
import 'package:aptiche/views/home/homescreen.dart';
import 'package:aptiche/widgets/buttons.dart';
import 'package:aptiche/widgets/textfeilds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DataEntryScreen extends GetView<DataEntryController> {
  const DataEntryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
      body: SafeArea(
        child: Stack(
          fit: StackFit.loose,
          children: <Widget>[
            Positioned(
              bottom: SizeConfig.screenHeight! * 0.6,
              left: SizeConfig.screenWidth! * 0.075,
              right: SizeConfig.screenWidth! * 0.075,
              child: SvgPicture.asset(
                dataEntryScreen,
                alignment: Alignment.center,
                height: SizeConfig.screenHeight! * 0.32,
              ),
            ),
            Positioned(
              bottom: SizeConfig.screenHeight! * 0.0001,
              child: Container(
                height: SizeConfig.screenHeight! * 0.51,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                        left: SizeConfig.safeBlockHorizontal! * 8,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Fill in the Information',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).primaryTextTheme.headline2,
                      ),
                    ),
                    Form(
                      key: controller.formKey,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.safeBlockHorizontal! * 6,
                            vertical: SizeConfig.safeBlockHorizontal! * 4),
                        child: Column(
                          children: <Widget>[
                            CustomTextField(
                              editingController:
                                  DataEntryController().nameController,
                              validator: (dynamic value) {
                                return Validator.validateName(
                                  DataEntryController().nameController.text,
                                );
                              },
                              label: 'Enter Name',
                              hint: 'John Doe',
                              type: TextInputType.name,
                              icon: Icons.person,
                            ),
                            CustomTextField(
                              editingController:
                                  DataEntryController().rollNoController,
                              validator: (dynamic value) {
                                return Validator.validateRoll(
                                  DataEntryController().rollNoController.text,
                                );
                              },
                              label: 'Enter Roll Number',
                              hint: '118CH001',
                              type: TextInputType.text,
                              icon: Icons.school_rounded,
                            ),
                            CustomTextField(
                              editingController:
                                  DataEntryController().emailController,
                              validator: (dynamic value) {
                                return Validator.validateEmail(
                                  DataEntryController().emailController.text,
                                );
                              },
                              label: 'Enter Email Address',
                              hint: 'foo@bar.in',
                              type: TextInputType.emailAddress,
                              icon: Icons.email_rounded,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      alignment: Alignment.center,
                      child: CustomButton(
                          text: 'PROCEED',
                          onTap: () {
                            if (controller.formKey.currentState!.validate()) {
                              Get.offAll<dynamic>(const HomeScreen());
                            }
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
