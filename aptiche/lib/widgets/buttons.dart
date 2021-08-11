import 'package:aptiche/utils/theme.dart';
import 'package:aptiche/utils/ui_scaling.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      this.text,
      @required this.onTap,
      required this.verticalPadding,
      required this.horizontalPadding})
      : super(key: key);
  final String? text;
  final VoidCallback? onTap;
  final double verticalPadding;
  final double horizontalPadding;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        primary: kPrimaryColor,
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.safeBlockHorizontal! * horizontalPadding,
          vertical: SizeConfig.safeBlockHorizontal! * verticalPadding,
        ),
        elevation: SizeConfig.safeBlockHorizontal,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            SizeConfig.safeBlockVertical! * 2.125,
          ),
        ),
      ),
      child: Text(
        text!,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: kTextColourWhite,
          fontFamily: kSfpro,
          fontSize: SizeConfig.safeBlockVertical! * 2.125,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
