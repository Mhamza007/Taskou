import 'package:flutter/cupertino.dart';

import '../../../../resources/resources.dart';

class DialogUtil {
  static Future<void> showDialogWithOKButton(
    BuildContext context, {
    String? title,
    required String message,
    Function()? callback,
    String? btnText,
    bool barrierDismissible = true,
    bool isError = false,
  }) async {
    await showCupertinoDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            title ?? Res.string.appTitle.toUpperCase(),
            style: TextStyle(
              color: isError ? Res.colors.redColor : Res.colors.materialColor,
            ),
          ),
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              onPressed: callback ??
                  () {
                    Navigator.pop(context);
                  },
              child: Text(
                btnText ?? Res.string.ok,
                style: TextStyle(
                  color: Res.colors.materialColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  static Future<void> showDialogWithYesNoButton(
    BuildContext context, {
    String? title,
    required String message,
    String? yesBtnText,
    String? noBtnText,
    Color? yesBtnColor,
    Color? noBtnColor,
    required Function() yesBtnCallback,
    Function()? noBtnCallback,
    bool barrierDismissible = true,
  }) async {
    await showCupertinoDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            title ?? Res.string.appTitle.toUpperCase(),
            style: TextStyle(
              color: Res.colors.materialColor,
            ),
          ),
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              onPressed: yesBtnCallback,
              child: Text(
                yesBtnText ?? Res.string.yes,
                style: TextStyle(
                  color: yesBtnColor ?? Res.colors.materialColor,
                ),
              ),
            ),
            CupertinoDialogAction(
              onPressed: noBtnCallback ??
                  () {
                    Navigator.pop(context);
                  },
              child: Text(
                noBtnText ?? Res.string.no,
                style: TextStyle(
                  color: noBtnColor ?? Res.colors.materialColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
