import 'package:firebase_auth/firebase_auth.dart';
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

  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoggedIn = false;
  // UserTable? _user;

  bool get isLoggedIn => _isLoggedIn;
  // UserTable? get user => _user;

  // void login(UserTable user) {
  //   _isLoggedIn = true;
  //   _user = user;
  // }

  /// Verify Phone Number
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    Duration duration = const Duration(seconds: 90),
    required Function(PhoneAuthCredential phoneAuthCredential) autoSignin,
    required Function(FirebaseAuthException authException) onVerificationFailed,
    required Function(String verificationId, int? resendToken) onCodeSent,
    required Function(String verificationId) onCodeAutoRetrievalTimeout,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: duration,
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
        await autoSignin(phoneAuthCredential);
      },
      verificationFailed: (FirebaseAuthException firebaseAuthException) async {
        await onVerificationFailed(firebaseAuthException);
      },
      codeSent: (String verificationId, int? resendToken) async {
        await onCodeSent(verificationId, resendToken);
      },
      codeAutoRetrievalTimeout: (String verificationId) async {
        await onCodeAutoRetrievalTimeout(verificationId);
      },
    );
  }

  Future<UserCredential> verifyCodeSignin({
    required String verificationId,
    required String code,
  }) async {
    AuthCredential authCredential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: code,
    );

    try {
      UserCredential userCredential = await _auth.signInWithCredential(
        authCredential,
      );
      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential> signinWithCredentials({
    required PhoneAuthCredential phoneAuthCredential,
  }) async {
    UserCredential userCredential = await _auth.signInWithCredential(
      phoneAuthCredential,
    );
    return userCredential;
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } finally {
      _isLoggedIn = false;
    }
  }
}
