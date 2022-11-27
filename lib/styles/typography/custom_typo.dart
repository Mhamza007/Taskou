import 'package:flutter/material.dart';

import '/styles/styles.dart';

class CustomTextStyle {
  static const TextStyle unfilledButtonTextStyle = TextStyle(
    fontSize: FontSize.f16,
    color: CustomColors.primaryColor,
    fontWeight: FontWeight.w500,
    height: 1.18,
  );
  static const TextStyle filledButtonTextStyle = TextStyle(
    fontSize: FontSize.f16,
    color: CustomColors.whiteColor,
    fontWeight: FontWeight.w500,
    height: 1.18,
  );
  static const TextStyle lightFilledButtonTextStyle = TextStyle(
    fontSize: FontSize.f14,
    color: CustomColors.primaryColor,
    fontWeight: FontWeight.w500,
    height: 1.143,
  );
}
