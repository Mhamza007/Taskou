import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../resources/resources.dart';
import '../../../app.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(context),
      child: BlocBuilder<SplashCubit, SplashState>(
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: SvgPicture.asset(
                Res.appTheme.getThemeMode() == ThemeMode.dark
                    ? Res.drawable.appLogoDark
                    : Res.drawable.appLogo,
              ),
            ),
          );
        },
      ),
    );
  }
}
