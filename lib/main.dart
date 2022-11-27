import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'app/app.dart';
import 'db/db.dart';
import 'resources/values/values.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await runZonedGuarded(
    () async {
      await GetStorage.init(USER_BOX);
      await GetStorage.init(THEME_BOX);

      if (kReleaseMode) {
        CustomImageCache();
      }

      runApp(const TaskouApp());
    },
    ((error, stack) {
      debugPrintStack(
        stackTrace: stack,
        label: error.toString(),
      );
    }),
  );
}
