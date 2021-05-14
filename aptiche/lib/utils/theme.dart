//colour used for buttons and other widgets
import 'package:flutter/material.dart';

const kPrimaryColor = const Color(0xff3385be);
const kSecondaryColor = const Color(0xff036197);
const kTertiaryColor = const Color(0xff0078bd);

//colour used for text
const kTextColourBlue = const Color(0xff005180);
const kTextColourBlack = const Color(0xff000000);
const kTextColourWhite = const Color(0xffffffff);

//colour used for background
const kBgColour = const Color(0xffffffff);

//font families
const String kPoppins = "Poppins";
const String kSfpro = "SFPro";

ThemeData appTheme() {
  return ThemeData(
    backgroundColor: kBgColour,
    appBarTheme: AppBarTheme(
      color: kBgColour,
      centerTitle: true,
    ),
    buttonColor: kPrimaryColor,
    primaryColor: kPrimaryColor,
    accentColor: kSecondaryColor,
    scaffoldBackgroundColor: kBgColour,
    primaryTextTheme: TextTheme(
      //Heading in Login-SignUp Screens, Quiz Heading in instruction page, Result diplay
      headline1: TextStyle(
        fontSize: 42,
        fontFamily: kSfpro,
        fontWeight: FontWeight.w700,
        color: kTextColourBlue,
      ),

      //Appbar titles
      headline2: TextStyle(
        fontSize: 22,
        fontFamily: kPoppins,
        fontWeight: FontWeight.w500,
        color: kTextColourBlue,
      ),

      // Quiz titles in cards
      headline3: TextStyle(
        fontSize: 18,
        fontFamily: kSfpro,
        fontWeight: FontWeight.w500,
        color: kTextColourBlue,
      ),

      //textbox label texts, drawer screen texts, sub-headings in quiz and instruction pages
      bodyText1: TextStyle(
        fontSize: 16,
        fontFamily: kSfpro,
        fontWeight: FontWeight.w500,
        color: kTextColourBlack,
      ),

      //general text
      bodyText2: TextStyle(
        fontSize: 14,
        fontFamily: kPoppins,
        fontWeight: FontWeight.normal,
        color: kTextColourBlack,
      ),
    ),
  );
}
