import 'package:flutter/widgets.dart';

// import '../../../../db/db.dart';
import '../../../app.dart';

enum AuthStatus {
  none,
  success,
  failed,
}

class AuthService {
  static final AuthService _authService = AuthService._internal();
  factory AuthService() => _authService;
  AuthService._internal() : super();

  static AuthService get to => _authService;

  bool _isLoggedIn = false;
  // UserTable? _user;

  bool get isLoggedIn => _isLoggedIn;
  // UserTable? get user => _user;

  // void login(UserTable user) {
  //   _isLoggedIn = true;
  //   _user = user;
  // }

  void logout() {
    _isLoggedIn = false;
    // _user = null;
  }

  // Future<UserTable?> checkExistingUser() async {
  //   try {
  //     var user = await UserDao.get().getLoggedUser();
  //     if (user != null) {
  //       login(user);
  //     }
  //     return user;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future<void> logoutUser(BuildContext context) async {
  //   try {
  //     int deleteUser = await UserDao.get().deleteTable();
  //     if (deleteUser > 0) {
  //       logout();
  //       Navigator.pushNamedAndRemoveUntil(
  //         context,
  //         Routes.signIn,
  //         (route) => false,
  //       );
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
