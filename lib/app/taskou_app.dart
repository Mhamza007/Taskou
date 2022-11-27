import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import '../resources/resources.dart';
import 'app.dart';

class TaskouApp extends StatelessWidget {
  const TaskouApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: Res.string.appTitle,
      themeMode: Res.appTheme.init(),
      translations: Res.appTranslations,
      locale: Res.appTranslations.locale,
      fallbackLocale: Res.appTranslations.fallbackLocale,
      localizationsDelegates: const [
        // Built-in localization of basic text for Material widgets
        GlobalMaterialLocalizations.delegate,
        // Built-in localization for text direction LTR/RTL
        GlobalWidgetsLocalizations.delegate,
      ],
      initialRoute: Routes.initial,
      onGenerateRoute: RouteGenerator.generateRoute,
      defaultTransition: Transition.cupertino,
      theme: Res.appTheme.lightTheme,
      darkTheme: Res.appTheme.darkTheme,
    );
  }
}
