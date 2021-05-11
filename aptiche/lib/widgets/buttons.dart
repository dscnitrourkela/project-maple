import 'package:aptiche/utils/theme.dart';
import 'package:aptiche/utils/ui_scaling.dart';
import 'package:flutter/material.dart';

ElevatedButton button(String text, Function onTap) {
  return ElevatedButton(
    onPressed: onTap,
    style: ElevatedButton.styleFrom(
      primary: kPrimaryColor,
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.safeBlockHorizontal * 15,
        vertical: SizeConfig.safeBlockHorizontal * 2,
      ),
      elevation: SizeConfig.safeBlockHorizontal,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          SizeConfig.safeBlockVertical * 2.125,
        ),
      ),
    ),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: kTextColourWhite,
        fontFamily: kSfpro,
        fontSize: SizeConfig.safeBlockVertical * 2.125,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}
