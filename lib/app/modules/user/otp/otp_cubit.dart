// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../db/db.dart';
import '../../../../resources/resources.dart';
import '../../../../sdk/sdk.dart';
import '../../../app.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit(
    this.context, {
    this.data,
  }) : super(const OtpState()) {
    pinController = TextEditingController();
    _userApi = UserApi();
    _authService = AuthService();
    _userStorage = UserStorage();

    getUserDetails();
    startTimer();
  }

  final BuildContext context;
  final Map? data;
  late final TextEditingController pinController;
  late final UserApi _userApi;
  late Timer timer;

  late final AuthService _authService;
  late final UserStorage _userStorage;

  void startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (state.seconds == 0) {
          timer.cancel();
          emit(
            state.copyWith(
              timeUp: true,
            ),
          );
        } else {
          emit(
            state.copyWith(
              seconds: state.seconds - 1,
            ),
          );
        }
      },
    );
  }

  void resendOtp() {
    emit(
      state.copyWith(
        seconds: 60,
        timeUp: false,
      ),
    );
    startTimer();
  }

  String getSeconds(int seconds) {
    if (seconds.toString().length < 2) {
      return '0$seconds';
    } else {
      return '$seconds';
    }
  }

  void getUserDetails() {
    if (data != null) {
      // var userData = data!['user_data'];
      // var verificationId = data!['verification_id'];
      // emit(
      //   state.copyWith(
      //     userData: userData,
      //     verificationId: verificationId,
      //     phoneNumber: data!['phone_number'],
      //   ),
      // );

      var userId = data!['user_id'];
      var mobileNumber = data!['mobile'];
      var otp = data!['otp'];
      pinController.text = '$otp';
      emit(
        state.copyWith(
          userId: '$userId',
          phoneNumber: '$mobileNumber',
          otp: '$otp',
        ),
      );
    }
  }

  void onTextChanged(String text) {
    emit(state.copyWith(buttonEnabled: text.length == 4));
  }

  Future<void> verifyOtp() async {
    if (timer.isActive) {
      timer.cancel();
    }
    try {
      emit(
        state.copyWith(
          authStatus: AuthStatus.none,
          status: VerifyStatus.loading,
        ),
      );
      var isConnected = await NetworkService().getConnectivity();
      // if (isConnected) {
      //   // Verify OTP with Firebase
      //   var firebaseVerification = await _verifyOtpFirebase();

      //   if (firebaseVerification['error'] == null) {
      //     // Success - OTP verified
      //     // Signup the user on Server

      //     await _signupOnServer();
      //   } else {
      //     emit(
      //       state.copyWith(
      //         authStatus: AuthStatus.failed,
      //         authMessage: firebaseVerification['error'],
      //       ),
      //     );
      //   }
      // } else {
      //   emit(
      //     state.copyWith(
      //       authStatus: AuthStatus.failed,
      //       authMessage: Res.string.youAreInOfflineMode,
      //     ),
      //   );
      // }
      var response = await _userApi.verifyOtp(
        userData: {
          'user_id': state.userId,
          'user_otp': pinController.text,
        },
      );

      debugPrint('${response?.toJson()}');

      if (response?.statusCode == 200) {
        emit(
          state.copyWith(
            authStatus: AuthStatus.success,
            authMessage:
                response?.message ?? Res.string.otpVerifiedSuccessfully,
          ),
        );

        await _userStorage.setUserToken(response?.data?.userToken);

        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.signIn,
          (route) => false,
        );
      } else {
        emit(
          state.copyWith(
            authStatus: AuthStatus.failed,
            authMessage: response?.message ?? Res.string.errorVerifyingOtp,
          ),
        );
      }
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          authStatus: AuthStatus.failed,
          authMessage: e.toString(),
        ),
      );
    } on ResponseException catch (e) {
      emit(
        state.copyWith(
          authStatus: AuthStatus.failed,
          authMessage: e.toString(),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          authStatus: AuthStatus.failed,
          authMessage: Res.string.errorVerifyingOtp,
        ),
      );
    } finally {
      emit(
        state.copyWith(
          status: VerifyStatus.loaded,
        ),
      );
    }
  }

  Future<Map> _verifyOtpFirebase() async {
    var responseData = {};

    try {
      var uesrCredential = await _authService.verifyCodeSignin(
        verificationId: state.verificationId!,
        code: pinController.text,
      );
      if (uesrCredential.user != null) {
        // Success - OTP verified
        responseData = {
          'error': null,
        };
      } else {
        responseData = {
          'error': Res.string.errorVerifyingOtp,
        };
      }
    } catch (e) {
      responseData = {
        'error': Res.string.errorVerifyingOtp,
      };
    }

    return responseData;
  }

  Future<void> _signupOnServer() async {
    try {
      var serverSignupResponse = await _userApi.signUpUser(
        userData: state.userData!,
      );
      debugPrint('${serverSignupResponse?.toJson()}');

      if (serverSignupResponse?.statusCode == 200) {
        // Verify the server generated OTP

        var serverOtpResponse = await _userApi.verifyOtp(
          userData: {
            'user_id': serverSignupResponse?.data?.userId,
            'user_otp': serverSignupResponse?.data?.userOtp,
          },
        );

        if (serverOtpResponse?.statusCode == 200) {
          // Server OTP verified

          await Future.wait(
            [
              _userStorage.setUserId(
                serverOtpResponse?.data?.userId,
              ),
              _userStorage.setUserMobile(
                serverOtpResponse?.data?.userMobile,
              ),
              _userStorage.setUserToken(
                serverOtpResponse?.data?.userToken,
              ),
              _userStorage.setUserFirstName(
                serverOtpResponse?.data?.firstName,
              ),
              _userStorage.setUserLastName(
                serverOtpResponse?.data?.lastName,
              ),
              _userStorage.setUserDeviceToken(
                serverOtpResponse?.data?.deviceToken,
              ),
              _userStorage.setUserData(
                jsonEncode(serverOtpResponse?.data?.toMap()),
              ),
            ],
          );

          emit(
            state.copyWith(
              authStatus: AuthStatus.success,
              authMessage: serverOtpResponse?.message ??
                  Res.string.otpVerifiedSuccessfully,
            ),
          );

          Navigator.pushNamed(
            context,
            Routes.signIn,
          );
        } else {
          emit(
            state.copyWith(
              authStatus: AuthStatus.failed,
              authMessage:
                  serverOtpResponse?.message ?? Res.string.errorVerifyingOtp,
            ),
          );
        }
      } else {
        emit(
          state.copyWith(
            authStatus: AuthStatus.failed,
            authMessage:
                serverSignupResponse?.message ?? Res.string.errorSigningUp,
          ),
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> close() {
    if (timer.isActive) {
      timer.cancel();
    }

    return super.close();
  }
}
