// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../resources.dart';

const String THEME_BOX = 'theme';
const String THEME_MODE = 'theme_mode';

class AppTheme {
  final String _sThemeModeLight = '_sThemeModeLight';
  final String _sThemeModeDark = '_sThemeModeDark';

  final getBox = GetStorage(THEME_BOX);

  final _lightTheme = ThemeData(
    primarySwatch: Res.colors.materialColor,
    scaffoldBackgroundColor: Res.colors.backgroundColorLight,
    appBarTheme: AppBarTheme(
      backgroundColor: Res.colors.appBarColor,
      centerTitle: true,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 20.0,
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
        size: 32,
      ),
      actionsIconTheme: const IconThemeData(
        color: Colors.white,
      ),
      toolbarTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 18.0,
      ),
      elevation: 0.0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Res.colors.lightBottomNavBarColor,
      selectedItemColor: Res.colors.materialColor,
      unselectedItemColor: Res.colors.lightBottomNavBarIconColor,
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: Res.colors.backgroundColorLight,
    ),
    listTileTheme: ListTileThemeData(
      tileColor: Res.colors.backgroundColorLight,
      textColor: Res.colors.textColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Res.colors.lightTextFieldBgColor,
      border: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Res.colors.textColor,
        ),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Res.colors.textColor,
        ),
      ),
      labelStyle: TextStyle(
        color: Res.colors.textColor,
      ),
      floatingLabelStyle: TextStyle(
        color: Res.colors.textColor,
      ),
      suffixIconColor: Colors.black,
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(
        color: Res.colors.textColor,
      ),
      bodyText2: TextStyle(
        color: Res.colors.textColor,
      ),
      button: TextStyle(
        color: Res.colors.textColor,
      ),
      caption: TextStyle(
        color: Res.colors.textColor,
      ),
      headline1: TextStyle(
        color: Res.colors.textColor,
      ),
      headline2: TextStyle(
        color: Res.colors.textColor,
      ),
      headline3: TextStyle(
        color: Res.colors.textColor,
      ),
      headline4: TextStyle(
        color: Res.colors.textColor,
      ),
      headline5: TextStyle(
        color: Res.colors.textColor,
      ),
      headline6: TextStyle(
        color: Res.colors.textColor,
      ),
      overline: TextStyle(
        color: Res.colors.textColor,
      ),
      subtitle1: TextStyle(
        color: Res.colors.textColor,
      ),
      subtitle2: TextStyle(
        color: Res.colors.textColor,
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Res.colors.backgroundColorLight,
      modalBackgroundColor: Res.colors.backgroundColorLight,
    ),
  );

  final _darkTheme = ThemeData(
    primarySwatch: Res.colors.materialColor,
    scaffoldBackgroundColor: Res.colors.backgroundColorDark,
    appBarTheme: AppBarTheme(
      backgroundColor: Res.colors.appBarColor,
      centerTitle: true,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 20.0,
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
        size: 32,
      ),
      actionsIconTheme: const IconThemeData(
        color: Colors.white,
      ),
      toolbarTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 18.0,
      ),
      elevation: 0.0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Res.colors.darkBottomNavBarColor,
      selectedItemColor: Res.colors.materialColor,
      unselectedItemColor: Res.colors.darkBottomNavBarIconColor,
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: Res.colors.backgroundColorDark,
    ),
    listTileTheme: ListTileThemeData(
      tileColor: Res.colors.backgroundColorDark,
      textColor: Res.colors.textColorDark,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Res.colors.darkTextFieldBgColor,
      border: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Res.colors.textColorDark,
        ),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Res.colors.textColorDark,
        ),
      ),
      labelStyle: TextStyle(
        color: Res.colors.textColorDark,
      ),
      floatingLabelStyle: TextStyle(
        color: Res.colors.textColorDark,
      ),
      suffixIconColor: Colors.white,
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(
        color: Res.colors.textColorDark,
      ),
      bodyText2: TextStyle(
        color: Res.colors.textColorDark,
      ),
      button: TextStyle(
        color: Res.colors.textColorDark,
      ),
      caption: TextStyle(
        color: Res.colors.textColorDark,
      ),
      headline1: TextStyle(
        color: Res.colors.textColorDark,
      ),
      headline2: TextStyle(
        color: Res.colors.textColorDark,
      ),
      headline3: TextStyle(
        color: Res.colors.textColorDark,
      ),
      headline4: TextStyle(
        color: Res.colors.textColorDark,
      ),
      headline5: TextStyle(
        color: Res.colors.textColorDark,
      ),
      headline6: TextStyle(
        color: Res.colors.textColorDark,
      ),
      overline: TextStyle(
        color: Res.colors.textColorDark,
      ),
      subtitle1: TextStyle(
        color: Res.colors.textColorDark,
      ),
      subtitle2: TextStyle(
        color: Res.colors.textColorDark,
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Res.colors.backgroundColorDark,
      modalBackgroundColor: Res.colors.backgroundColorDark,
    ),
  );

  /// Light Theme
  ThemeData get lightTheme => _lightTheme;

  /// Dark Theme
  ThemeData get darkTheme => _darkTheme;

  ThemeMode init() {
    String? themeMode = getBox.read(THEME_MODE);
    if (themeMode == _sThemeModeDark) {
      return ThemeMode.dark;
    } else if (themeMode == _sThemeModeLight) {
      return ThemeMode.light;
    } else {
      return ThemeMode.system;
    }
  }

  void changeThemeMode(ThemeMode themeMode) {
    if (themeMode == ThemeMode.dark) {
      getBox.write(THEME_MODE, _sThemeModeDark);
    } else if (themeMode == ThemeMode.light) {
      getBox.write(THEME_MODE, _sThemeModeLight);
    }
    Get.changeThemeMode(themeMode);
    Get.rootController.themeMode.reactive;
  }

  ThemeMode getThemeMode() {
    String? themeMode = getBox.read(THEME_MODE);
    if (themeMode == _sThemeModeDark) {
      return ThemeMode.dark;
    } else if (themeMode == _sThemeModeLight) {
      return ThemeMode.light;
    } else {
      return ThemeMode.system;
    }
  }
}
