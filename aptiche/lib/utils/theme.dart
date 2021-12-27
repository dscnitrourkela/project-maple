// ignore_for_file: avoid_classes_with_only_static_members

import 'package:flutter/material.dart';

//colour used for buttons and other widgets
const Color kPrimaryColor = Color(0xff3385be);
const Color kSecondaryColor = Color(0xff036197);
const Color kTertiaryColor = Color(0xff0078bd);

//colour used for text
const Color kTextColourBlue = Color(0xff005180);
const Color kTextColourBlack = Color(0xff000000);
const Color kTextColourWhite = Color(0xffffffff);

//colour used for background
const Color kBgColour = Color(0xffffffff);
const Color kGreyBgColor = Color(0xfff6f6f6);

//colour for snackbarBackground
const Color kSnackColour = Color(0xffade8f4);

//font families
const String kPoppins = 'Poppins';
const String kSfpro = 'SFPro';

class AppThemes {
  static final ThemeData lightThemeData = ThemeData(
    backgroundColor: kBgColour,
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: kTextColourBlue),
      color: kGreyBgColor,
      centerTitle: true,
    ),
    primaryColor: kPrimaryColor,
    secondaryHeaderColor: kSecondaryColor,
    scaffoldBackgroundColor: kGreyBgColor,
    primaryTextTheme: const TextTheme(
      //Heading in Login-SignUp Screens, Quiz Heading in instruction page, Result diplay
      headline1: TextStyle(
        fontSize: 32,
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
        fontSize: 17,
        fontFamily: kSfpro,
        fontWeight: FontWeight.w500,
        color: kTextColourBlue,
      ),

      //textbox label texts, drawer screen texts, sub-headings in quiz and instruction pages
      bodyText1: TextStyle(
        fontSize: 14,
        fontFamily: kSfpro,
        fontWeight: FontWeight.w500,
        color: kTextColourBlack,
      ),

      //general text
      bodyText2: TextStyle(
        fontSize: 12,
        fontFamily: kPoppins,
        fontWeight: FontWeight.normal,
        color: kTextColourBlack,
      ),
    ),
    iconTheme: const IconThemeData(color: kTextColourBlue, opacity: 0.8),
  );

  static final ThemeData darkThemeData = ThemeData(
      canvasColor: Colors.black,
      backgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        color: Colors.black,
        centerTitle: true,
      ),
      primaryColor: Colors.black,
      secondaryHeaderColor: kSecondaryColor,
      scaffoldBackgroundColor: Colors.black,
      primaryTextTheme: const TextTheme(
        //Heading in Login-SignUp Screens, Quiz Heading in instruction page, Result diplay
        headline1: TextStyle(
          fontSize: 32,
          fontFamily: kSfpro,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),

        //Appbar titles
        headline2: TextStyle(
          fontSize: 22,
          fontFamily: kPoppins,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),

        // Quiz titles in cards
        headline3: TextStyle(
          fontSize: 17,
          fontFamily: kSfpro,
          fontWeight: FontWeight.w500,
          color: kTextColourBlue,
        ),
        //textbox label texts, drawer screen texts, sub-headings in quiz and instruction pages
        bodyText1: TextStyle(
          fontSize: 14,
          fontFamily: kSfpro,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),

        //general text
        bodyText2: TextStyle(
          fontSize: 12,
          fontFamily: kPoppins,
          fontWeight: FontWeight.normal,
          color: kTextColourBlack,
        ),
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ));
}
