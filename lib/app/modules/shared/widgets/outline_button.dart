import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../resources/resources.dart';

class OutlineButton extends StatelessWidget {
  OutlineButton({
    super.key,
    this.onPressed,
    this.titleWidget,
    this.title,
  }) {
    assert(titleWidget != null || title != null);
  }

  final Widget? titleWidget;
  final String? title;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Res.appTheme.getThemeMode() == ThemeMode.dark;

    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        side: MaterialStateProperty.all(
          BorderSide(
            width: 2.0,
            color: Res.colors.materialColor,
          ),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(
          isDarkMode ? Res.colors.lightGreyColor : Res.colors.whiteColor,
        ),
      ),
      child: titleWidget ??
          Text(
            title!,
            style: const TextStyle(
              fontSize: 18.0,
            ),
          ).paddingSymmetric(
            vertical: 20.0,
          ),
    );
  }
}
