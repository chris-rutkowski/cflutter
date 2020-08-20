import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData lightTheme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
//    fontFamily: 'BalooThambi2',
    appBarTheme: AppBarTheme(
      elevation: 2,
      brightness: Brightness.light,
      color: Colors.white,
      textTheme: TextTheme(
        headline6: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 24,
//            fontFamily: 'BalooThambi2',
            color: primaryTextColor),
      ),
      iconTheme: IconThemeData(color: primary),
      actionsIconTheme: IconThemeData(color: primary),
    ),
    iconTheme: IconThemeData(color: primary),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.w800,
        fontSize: 36,
//        fontFamily: 'BalooThambi2',
      ),
      headline2: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.w700,
        fontSize: 24,
//        fontFamily: 'BalooThambi2',
      ),
      headline3: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.w600,
        fontSize: 18,
//        fontFamily: 'BalooThambi2',
      ),
      headline4: TextStyle(
        color: secondaryTextColor,
        fontWeight: FontWeight.w500,
        fontSize: 14,
//        fontFamily: 'BalooThambi2',
      ),
      headline5: TextStyle(
        color: secondaryTextColor,
        fontWeight: FontWeight.w500,
        fontSize: 12,
//        fontFamily: 'BalooThambi2',
      ),
      headline6: TextStyle(
        color: secondaryTextColor,
        fontWeight: FontWeight.w600,
        fontSize: 10,
//        fontFamily: 'BalooThambi2',
      ),
      // paragraph
      bodyText1: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.w400,
        fontSize: 16,
//        fontFamily: 'BalooThambi2',
      ),
      bodyText2: TextStyle(
        color: secondaryTextColor,
        fontWeight: FontWeight.w400,
        fontSize: 15,
//        fontFamily: 'BalooThambi2',
      ),
      button: TextStyle(
        color: primary,
        fontWeight: FontWeight.w600,
        fontSize: 18,
//        fontFamily: 'BalooThambi2',
      ),
    ),
    disabledColor: primaryTextColor.withOpacity(0.38),
    accentColor: mercury,
    colorScheme: ColorScheme(
      primary: primary,
      primaryVariant: Colors.yellow,
      secondary: Colors.yellow,
      secondaryVariant: Colors.yellow,
      surface: Color(0xFFF7F9F9),
      background: Colors.white,
      error: Color(0xFFCC0000),
      onPrimary: Colors.white,
      onSecondary: Colors.yellow,
      onSurface: Colors.yellow,
      onBackground: Colors.yellow,
      onError: Colors.white,
      brightness: Brightness.light,
    ),
    toggleableActiveColor: primary,
    splashColor: mercury,
    highlightColor: mercury.withOpacity(0.5),
    dividerTheme: DividerThemeData(
      color: mercury,
      thickness: 1,
      space: 0,
    ),
    sliderTheme: SliderThemeData(
      activeTickMarkColor: Colors.white,
      inactiveTickMarkColor: Colors.white,
      inactiveTrackColor: mercury,
      valueIndicatorColor: primary,
      valueIndicatorTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 18,
//        fontFamily: 'BalooThambi2',
      ),
    ),
    hintColor: silver,
  );
}
