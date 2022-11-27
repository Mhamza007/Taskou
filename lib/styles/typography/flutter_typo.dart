import 'package:flutter/material.dart';

import '../../styles/styles.dart';

class FlutterTextTheme {
  static TextTheme lightTextTheme = const TextTheme(
    headline2: TextStyle(
      fontSize: FontSize.f34,
      color: CustomColors.primaryTextColor,
      fontWeight: FontWeight.bold,
    ),
    headline3: TextStyle(
      fontSize: FontSize.f24,
      color: CustomColors.primaryTextColor,
      fontWeight: FontWeight.bold,
    ),
    headline4: TextStyle(
      fontSize: FontSize.f20,
      color: CustomColors.primaryTextColor,
      fontWeight: FontWeight.bold,
    ),
    headline5: TextStyle(
      fontSize: FontSize.f18,
      color: CustomColors.primaryTextColor,
      fontWeight: FontWeight.bold,
    ),
    headline6: TextStyle(
      fontSize: FontSize.f16,
      color: CustomColors.primaryTextColor,
      fontWeight: FontWeight.bold,
    ),
    subtitle1: TextStyle(
      fontSize: FontSize.f16,
      fontWeight: FontWeight.w400,
      color: CustomColors.primaryTextColor,
    ),
    subtitle2: TextStyle(
      fontSize: FontSize.f14,
      fontWeight: FontWeight.w400,
      color: CustomColors.lightBlackColor,
    ),
    bodyText1: TextStyle(
      fontSize: FontSize.f14,
      fontWeight: FontWeight.w500,
      color: CustomColors.lightBlackColor,
    ),
    bodyText2: TextStyle(
      fontSize: FontSize.f14,
      fontWeight: FontWeight.w400,
      color: CustomColors.primaryTextColor,
    ),
    button: TextStyle(
      fontSize: FontSize.f16,
      fontWeight: FontWeight.bold,
      color: CustomColors.whiteColor,
    ),
    caption: TextStyle(
      fontSize: FontSize.f12,
      fontWeight: FontWeight.w400,
      color: CustomColors.primaryTextColor,
    ),
  );
}
