import 'package:aptiche/utils/string.dart';
import 'package:aptiche/utils/theme.dart';
import 'package:aptiche/utils/ui_scaling.dart';
import 'package:aptiche/views/dataentry/dataentry_controller.dart';
import 'package:aptiche/views/splashscreen/splashscreen.dart';
import 'package:aptiche/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DataEntryScreen extends GetView<DataEntryController> {
  const DataEntryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: controller.readUser(),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.data == null) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: const Center(
              child: CircularProgressIndicator(
                backgroundColor: kPrimaryColor,
              ),
            ),
          );
        }
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SafeArea(
            child: Stack(
              fit: StackFit.loose,
              children: <Widget>[
                Positioned(
                  bottom: SizeConfig.screenHeight! * 0.6,
                  left: SizeConfig.screenWidth! * 0.075,
                  right: SizeConfig.screenWidth! * 0.075,
                  child: SvgPicture.asset(
                    Strings.dataEntryScreen,
                    alignment: Alignment.center,
                    placeholderBuilder: (BuildContext context) => Container(
                        padding: const EdgeInsets.all(30.0),
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator()),
                    height: SizeConfig.screenHeight! * 0.32,
                  ),
                ),
                Positioned(
                  bottom: SizeConfig.screenHeight! * 0.0001,
                  child: Container(
                    height: SizeConfig.screenHeight! * 0.6,
                    padding: EdgeInsets.only(
                      top: SizeConfig.safeBlockVertical! * 4,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
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
                                Container(
                                  width: SizeConfig.screenWidth! * 0.85,
                                  padding: EdgeInsets.symmetric(
                                      vertical: SizeConfig.safeBlockVertical!),
                                  child: TextFormField(
                                    keyboardType: TextInputType.name,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    controller: controller.nameController,
                                    validator: (String? value) {
                                      if (value!.trim() == null ||
                                          value.isEmpty) {
                                        return 'Please enter a valid name';
                                      }
                                      return null;
                                    },
                                    onSaved: (String? value) {
                                      controller.nameController.text =
                                          value.toString();
                                    },
                                    style: const TextStyle(
                                        color: kTextColourBlack),
                                    enableSuggestions: true,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              SizeConfig.safeBlockHorizontal! *
                                                  7.5),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: kSecondaryColor),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: kTertiaryColor),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      prefixIcon: const Icon(Icons.person,
                                          color: kTextColourBlack),
                                      labelText: 'Enter Name',
                                      labelStyle: const TextStyle(
                                          color: kTextColourBlack),
                                      alignLabelWithHint: true,
                                      hintText: 'John Doe',
                                      hintStyle:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: SizeConfig.screenWidth! * 0.85,
                                  padding: EdgeInsets.symmetric(
                                      vertical: SizeConfig.safeBlockVertical!),
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    textCapitalization:
                                        TextCapitalization.characters,
                                    controller: controller.rollNoController,
                                    validator: (String? value) {
                                      if (value!.trim().length != 9 ||
                                          value.isEmpty ||
                                          !value[3].isAlphabetOnly ||
                                          !value[4].isAlphabetOnly) {
                                        return 'Please enter a valid NIT Rourkela Roll Number';
                                      }
                                      return null;
                                    },
                                    onSaved: (String? value) {
                                      controller.rollNoController.text =
                                          value.toString();
                                    },
                                    style: const TextStyle(
                                        color: kTextColourBlack),
                                    enableSuggestions: true,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              SizeConfig.safeBlockHorizontal! *
                                                  7.5),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: kSecondaryColor),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: kTertiaryColor),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      prefixIcon: const Icon(
                                          Icons.school_rounded,
                                          color: kTextColourBlack),
                                      labelText: 'Enter Roll Number',
                                      labelStyle: const TextStyle(
                                          color: kTextColourBlack),
                                      alignLabelWithHint: true,
                                      hintText: '118CH001',
                                      hintStyle:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: SizeConfig.screenWidth! * 0.85,
                                  padding: EdgeInsets.symmetric(
                                      vertical: SizeConfig.safeBlockVertical!),
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    controller: controller.emailController,
                                    validator: (String? value) {
                                      if (value!.trim() == null ||
                                          !value.isEmail) {
                                        return 'Please enter a valid e-mail address';
                                      }
                                      return null;
                                    },
                                    onSaved: (String? value) {
                                      controller.emailController.text =
                                          value.toString();
                                    },
                                    style: const TextStyle(
                                        color: kTextColourBlack),
                                    enableSuggestions: true,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              SizeConfig.safeBlockHorizontal! *
                                                  7.5),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: kSecondaryColor),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: kTertiaryColor),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      prefixIcon: const Icon(
                                          Icons.email_rounded,
                                          color: kTextColourBlack),
                                      labelText: 'Enter Email Address',
                                      labelStyle: const TextStyle(
                                          color: kTextColourBlack),
                                      alignLabelWithHint: true,
                                      hintText: 'foo@bar.in',
                                      hintStyle:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: SizeConfig.screenWidth,
                          alignment: Alignment.center,
                          child: CustomButton(
                              horizontalPadding:
                                  SizeConfig.safeBlockHorizontal! * 3.5,
                              verticalPadding:
                                  SizeConfig.safeBlockVertical! * 0.27,
                              text: 'PROCEED',
                              onTap: () async {
                                if (controller.formKey.currentState!
                                    .validate()) {
                                  controller.formKey.currentState!.save();
                                  controller.writeUser(
                                    controller.nameController.text,
                                    controller.rollNoController.text,
                                    controller.emailController.text,
                                    controller.phoneNo.toString(),
                                  );

                                  await Get.offAll<SplashScreen>(
                                      () => const SplashScreen());
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
      },
    );
  }
}
