import 'package:flutter/material.dart';

import '../styles.dart';

class Shadows {
  static const mapListingCardShadow = BoxShadow(
    color: CustomColors.shadowColor,
    blurRadius: Sizes.s16,
    offset: Offset(0, Sizes.s20),
  );
  static const mapListingCardShadow2 = BoxShadow(
    color: CustomColors.shadowColor2,
    blurRadius: Sizes.s4,
    offset: Offset(0, 2),
  );
  static const mapListingShadow = BoxShadow(
    color: CustomColors.shadowColor3,
    blurRadius: Sizes.s12,
    spreadRadius: Sizes.s8,
    offset: Offset(0, Sizes.s10),
  );
  static const exploreAppBarShadow = BoxShadow(
    color: CustomColors.shadowColor,
    blurRadius: Sizes.s4,
    offset: Offset(0, 2),
  );
  static const exploreListingCardShadow = BoxShadow(
    color: CustomColors.shadowColor,
    blurRadius: Sizes.s10,
    offset: Offset(0, 5),
  );
  static const bottomNavBarShadow = BoxShadow(
    offset: Offset(0, -1),
    blurRadius: Sizes.s4,
    color: CustomColors.bottomAppBarShadowColor,
  );
}
