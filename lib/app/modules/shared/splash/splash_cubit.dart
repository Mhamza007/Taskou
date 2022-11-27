import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskou/db/db.dart';

import '../../../app.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this.context) : super(const SplashState()) {
    _userStorage = UserStorage();

    init();
  }

  final BuildContext context;
  late UserStorage _userStorage;

  navigateToLogin() {
    Navigator.pushReplacementNamed(context, Routes.signIn);
  }

  navigateToDashboard() {
    Navigator.pushReplacementNamed(context, Routes.dashboard);
  }

  init() async {
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
