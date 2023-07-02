// ignore_for_file: use_build_context_synchronously

import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:taskou/db/db.dart';

import '../../../../resources/resources.dart';
import '../../../app.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this.context) : super(const SplashState()) {
    _userStorage = UserStorage();
    _firebaseDatabase = FirebaseDatabase.instance;

    init();
    InAppUpdate.checkForUpdate().then((info) {
      _updateInfo = info;
    }).catchError((e) {
      debugPrint('$e');
    });
  }

  final BuildContext context;
  late UserStorage _userStorage;
  late PackageInfo _packageInfo;
  late FirebaseDatabase _firebaseDatabase;
  late DatabaseReference _databaseReference;
  AppUpdateInfo? _updateInfo;

  navigateToLogin() {
    Navigator.pushReplacementNamed(context, Routes.signIn);
  }

  navigateToDashboard() {
    Navigator.pushReplacementNamed(context, Routes.dashboard);
  }

  Future<void> getAppUpdateVersion() async {
    try {
      _packageInfo = await PackageInfo.fromPlatform();
      var version = int.parse(_packageInfo.version.replaceAll('.', ''));

      _databaseReference = _firebaseDatabase.ref('taskou-update');
      var appUpdates = await _databaseReference.get();
      Map? data = appUpdates.value as Map?;
      var hardVersion = int.parse(
        '${data?['hardupdateversion'] ?? '1.0.0'}'.replaceAll('.', ''),
      );
      var softVersion = int.parse(
        '${data?['softupdateversion'] ?? '1.0.0'}'.replaceAll('.', ''),
      );

      if (hardVersion > version) {
        // show force uopdate dialog
        await DialogUtil.showDialogWithOKButton(
          context,
          message: data?['hardupdatemessage'] ??
              Res.string.pleaseUpdateAppToLatestVersion,
          barrierDismissible: false,
          btnText: Res.string.update,
          callback: () async {
            var updated = await updateApp();
            if (updated) {
              Navigator.pop(context);
            }
          },
        );
      } else if (softVersion > version) {
        // show optional version update dialog with
        await DialogUtil.showDialogWithYesNoButton(
          context,
          message: data?['softupdatemessage'] ??
              Res.string.pleaseUpdateAppToLatestVersion,
          barrierDismissible: false,
          noBtnText: Res.string.later,
          yesBtnText: Res.string.update,
          yesBtnCallback: () async {
            var updated = await updateApp();
            if (updated) {
              Navigator.pop(context);
            }
          },
        );
      } else {
        // continue
      }
    } catch (e) {
      // skip
      debugPrint('$e');
    }
  }

  Future<bool> updateApp() async {
    var updated = false;
    try {
      if (_updateInfo?.updateAvailability ==
          UpdateAvailability.updateAvailable) {
        var updateResult = await InAppUpdate.performImmediateUpdate();
        updated = updateResult == AppUpdateResult.success;
      } else {
        debugPrint('update not available');
      }
    } catch (e) {
      debugPrint('$e');
    }

    return updated;
  }

  init() async {
    await getAppUpdateVersion();
    var userId = _userStorage.getUserId();
    var userData = _userStorage.getUserData();
    await Future.delayed(const Duration(seconds: 2));

    if (userId != null && userData != null) {
      navigateToDashboard();
    } else {
      navigateToLogin();
    }
  }
}
