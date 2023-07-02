import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../../resources/resources.dart';

class Helpers {
  static void unFocus() {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
  }

  static void setStatusBarColor(
    Color color,
  ) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        statusBarColor: color,
      ),
    );
  }

  static Map<String, dynamic>? mergeMaps(
    Map<String, dynamic> firstMap,
    Map<String, dynamic> secondMap,
  ) {
    try {
      var mapList = [
        {...firstMap},
        {...secondMap}
      ];
      return mapList.reduce((map1, map2) => map1..addAll(map2));
    } catch (_) {}
  }

  static successSnackBar({
    required BuildContext context,
    required String title,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Res.colors.materialColor,
        elevation: 12,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.fromLTRB(
          16,
          16,
          16,
          32,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 20,
        ),
        content: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyText2
              ?.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  static errorSnackBar({
    required BuildContext context,
    required String title,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        elevation: 12,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.fromLTRB(
          16,
          16,
          16,
          32,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 20,
        ),
        content: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyText2
              ?.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  static String? bookingsDateTime(String? dateTime) {
    try {
      if (dateTime != null && dateTime.isNotEmpty) {
        var dT = DateTime.fromMillisecondsSinceEpoch(int.parse(dateTime));
        var month = monthNameFromNumber(dT.month);
        var hour = dT.hour > 12 ? '${dT.hour - 12}' : '${dT.hour}';
        hour = hour.toString().length < 2 ? '0$hour' : hour;
        var minute =
            dT.minute.toString().length < 2 ? '0${dT.minute}' : '${dT.minute}';
        var ampm = dT.hour > 12 ? Res.string.pm : Res.string.am;
        return '$month ${dT.day}, $hour:$minute $ampm';
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static String? getScheduleDateTime({
    String? scheduleDate,
    String? scheduleTime,
  }) {
    String? scheduleDateTime;
    try {
      if (scheduleDate != null && scheduleDate.isNotEmpty) {
        var sD = DateFormat('MMM dd').format(
          DateFormat('yyyy-MM-dd').parse(scheduleDate),
        );
        scheduleDateTime = sD;
        if (scheduleTime != null && scheduleTime.isNotEmpty) {
          var sT = DateFormat('hh:mm a').format(
            DateFormat('hh:mm:ss').parse(scheduleTime),
          );

          scheduleDateTime = '$scheduleDateTime $sT';
        }
      } else {
        return null;
      }
    } catch (_) {
      return null;
    }
    return scheduleDateTime;
  }

  static String monthNameFromNumber(int month) {
    switch (month) {
      case 1:
        return Res.string.jan;
      case 2:
        return Res.string.feb;
      case 3:
        return Res.string.mar;
      case 4:
        return Res.string.apr;
      case 5:
        return Res.string.may;
      case 6:
        return Res.string.jun;
      case 7:
        return Res.string.jul;
      case 8:
        return Res.string.aug;
      case 9:
        return Res.string.sep;
      case 10:
        return Res.string.oct;
      case 11:
        return Res.string.nov;
      case 12:
        return Res.string.dec;
      default:
        return '';
    }
  }
}
