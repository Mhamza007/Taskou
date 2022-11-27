import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

export 'typography/typography.dart';
export 'layouts/layouts.dart';
export 'colors/colors.dart';

import '../styles/styles.dart';

class Styles {
  static final ThemeData _lightTheme = ThemeData(
    fontFamily: 'Roboto',
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        statusBarColor: CustomColors.whiteColor,
      ),
    ),
    textTheme: FlutterTextTheme.lightTextTheme,
    scaffoldBackgroundColor: CustomColors.whiteColor,
  );

  static ThemeData get lightTheme => _lightTheme;
}
