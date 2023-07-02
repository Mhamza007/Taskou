// ignore_for_file: use_build_context_synchronously

import 'package:country_picker/country_picker.dart' as country_picker;
import 'package:country_picker/src/utils.dart' as country_picker;
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../resources/resources.dart';
import '../../../../sdk/sdk.dart';
import '../../../app.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit(this.context) : super(const ForgotPasswordState()) {
    forgotPasswordForm = ForgotPasswordForm.forgotPasswordForm;
    verifyForgetPasswordForm = ForgotPasswordForm.verifyForgetPasswordForm;
    updatePasswordForm = ForgotPasswordForm.updatePasswordForm;
    pageController = PageController();
    pinController = TextEditingController();
    _userApi = UserApi();
    _authService = AuthService();

    _initialCountry();
  }

  final BuildContext context;
  late final FormGroup forgotPasswordForm;
  late final FormGroup verifyForgetPasswordForm;
  late final FormGroup updatePasswordForm;
  late PageController pageController;
  late final TextEditingController pinController;
  late final UserApi _userApi;
  late final AuthService _authService;

  void _initialCountry() {
    var countryCodeControl = forgotPasswordForm.control(
      AuthForms.countryCodeControl,
    ) as FormControl;
    var phoneControl = forgotPasswordForm.control(
      AuthForms.userMobileControl,
    ) as FormControl;

    var initialCountryMap = {
      "e164_cc": "1",
      "iso2_cc": "US",
      "e164_sc": 0,
      "geographic": true,
      "level": 1,
      "name": "United States",
      "example": "2012345678",
      "display_name": "United States (US) [+1]",
      "full_example_with_plus_sign": "+12012345678",
      "display_name_no_e164_cc": "United States (US)",
      "e164_key": "1-US-0",
    };
    country_picker.Country country = country_picker.Country.from(
      json: initialCountryMap,
    );
    emit(
      state.copyWith(
        countryCode: '+${country.phoneCode}',
        flag: country_picker.Utils.countryCodeToEmoji(country.countryCode),
        maxLength: country.example.isNotEmpty ? country.example.length : null,
        hint: country.example,
        examplePhoneNumber: country.example,
      ),
    );
    phoneControl.setValidators(
      [
        Validators.required,
        Validators.minLength(country.example.length),
        Validators.maxLength(country.example.length),
      ],
    );
    countryCodeControl.updateValue(state.countryCode);
    phoneControl.updateValue('');
  }

  void selectCountry() {
    var countryCodeControl = forgotPasswordForm.control(
      AuthForms.countryCodeControl,
    ) as FormControl;
    var phoneControl = forgotPasswordForm.control(
      AuthForms.userMobileControl,
    ) as FormControl;

    country_picker.showCountryPicker(
      context: context,
      showPhoneCode: true,
      countryListTheme: country_picker.CountryListThemeData(
        borderRadius: BorderRadius.circular(20.0),
      ),
      onSelect: (country_picker.Country value) {
        emit(
          state.copyWith(
            countryCode: '+${value.phoneCode}',
            flag: country_picker.Utils.countryCodeToEmoji(value.countryCode),
            maxLength: value.example.isNotEmpty ? value.example.length : null,
            hint: value.example,
            examplePhoneNumber: value.example.isNotEmpty ? value.example : '',
          ),
        );
        phoneControl.setValidators(
          [
            Validators.required,
            Validators.minLength(value.example.length),
            Validators.maxLength(value.example.length),
          ],
        );
        countryCodeControl.updateValue(state.countryCode);
        phoneControl.updateValue('');
        debugPrint('selected country ${value.toJson()}');
      },
    );
  }

  bool isPhoneValid() {
    return (forgotPasswordForm.control('phone') as FormControl)
            .value
            .toString()
            .length ==
        state.examplePhoneNumber?.length;
  }

  Future<void> onSendButtonPressed() async {
    if (forgotPasswordForm.valid) {
      Helpers.unFocus();
      try {
        // emit(
        //   state.copyWith(
        //     status: VerifyStatus.loading,
        //     authStatus: AuthStatus.none,
        //   ),
        // );
        var isConnected = await NetworkService().getConnectivity();
        if (isConnected) {
          debugPrint('${forgotPasswordForm.value}');

          // Firebase Auth
          var countryCode = forgotPasswordForm
              .control(
                ForgotPasswordForm.countryCodeControl,
              )
              .value;
          var contactNumber = forgotPasswordForm
              .control(
                ForgotPasswordForm.userMobileControl,
              )
              .value;

          await _verifyOtpOnServer();
          // pageController.jumpToPage(2);

          // await _authService.verifyPhoneNumber(
          //   phoneNumber: '$countryCode$contactNumber',
          //   autoSignin: (phoneAuthCredential) async {
          //     var firebaseAuthResult = {
          //       'credential': phoneAuthCredential,
          //       'verificationId': phoneAuthCredential.verificationId,
          //       'error': null,
          //     };
          //     await _continueWithFirebaseResponse(
          //       firebaseAuthResult,
          //       '$countryCode $contactNumber',
          //     );
          //   },
          //   onVerificationFailed: (firebaseAuthException) async {
          //     var responseData = {};
          //     switch (firebaseAuthException.code) {
          //       case 'invalid-phone-number':
          //         // Invalid phone
          //         responseData = {
          //           'error': 'Invalid phone number',
          //         };
          //         break;
          //       case 'quota-exceeded':
          //         // Quota Exceeded
          //         responseData = {
          //           'error': 'SMS quota exceeded. Please wait for some time',
          //         };
          //         break;
          //       case 'user-disabled':
          //         // User disabled
          //         responseData = {
          //           'error': 'Unable to perform login with the phone number',
          //         };
          //         break;
          //       case 'captcha-check-failed':
          //         // Thrown if the reCAPTCHA response token was invalid, expired, or if this method was called from a non-whitelisted domain.
          //         responseData = {
          //           'error': 'reCAPTCHA failed. Please try again',
          //         };
          //         break;
          //       case 'missing-phone-number':
          //         // Thrown if the phone number is missing
          //         responseData = {
          //           'error': 'The provided phone number is missing',
          //         };
          //         break;
          //       case 'too-many-requests':
          //         // Thrown if the phone number is missing
          //         responseData = {
          //           'error':
          //               'We have blocked all requests from this device due to unusual activity. Try again later.',
          //         };
          //         break;
          //       default:
          //         responseData = {
          //           'error': firebaseAuthException.message ??
          //               Res.string.errorSigningUp,
          //         };
          //         break;
          //     }
          //     emit(
          //       state.copyWith(
          //         authStatus: AuthStatus.failed,
          //         authMessage:
          //             responseData['error'] ?? Res.string.errorSigningUp,
          //         status: VerifyStatus.loaded,
          //       ),
          //     );
          //   },
          //   onCodeSent: (String verificationId, int? resendToken) async {
          //     var firebaseAuthResult = {
          //       'verificationId': verificationId,
          //       'resendToken': resendToken,
          //       'error': null,
          //     };
          //     await _continueWithFirebaseResponse(
          //       firebaseAuthResult,
          //       '$countryCode $contactNumber',
          //     );
          //   },
          //   onCodeAutoRetrievalTimeout: (String verificationId) async {},
          // );
        } else {
          emit(
            state.copyWith(
              authStatus: AuthStatus.failed,
              authMessage: Res.string.youAreInOfflineMode,
              status: VerifyStatus.loaded,
            ),
          );
        }
      } on NetworkException catch (e) {
        emit(
          state.copyWith(
            authStatus: AuthStatus.failed,
            authMessage: e.toString(),
            status: VerifyStatus.loaded,
          ),
        );
      } on ResponseException catch (e) {
        emit(
          state.copyWith(
            authStatus: AuthStatus.failed,
            authMessage: e.toString(),
            status: VerifyStatus.loaded,
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            authStatus: AuthStatus.failed,
            authMessage: Res.string.errorSigningUp,
            status: VerifyStatus.loaded,
          ),
        );
      }
    } else {
      forgotPasswordForm.markAllAsTouched();
    }
  }

  Future<void> verifyOtp() async {
    try {
      emit(
        state.copyWith(
          authStatus: AuthStatus.none,
          status: VerifyStatus.loading,
        ),
      );
      var isConnected = await NetworkService().getConnectivity();
      if (isConnected) {
        await _verifyOtpOnServer();

        // // Verify OTP with Firebase
        // var firebaseVerification = await _verifyOtpFirebase();
        // if (firebaseVerification['error'] == null) {
        //   // Success - OTP verified
        //   // Verify OTP the user on Server

        //   await _verifyOtpOnServer();
        // } else {
        //   emit(
        //     state.copyWith(
        //       authStatus: AuthStatus.failed,
        //       authMessage: firebaseVerification['error'],
        //     ),
        //   );
        // }
      } else {
        emit(
          state.copyWith(
            authStatus: AuthStatus.failed,
            authMessage: Res.string.youAreInOfflineMode,
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

  Future<void> confirmPassword() async {
    if (updatePasswordForm.valid) {
      try {
        emit(
          state.copyWith(
            authStatus: AuthStatus.none,
            status: VerifyStatus.loading,
          ),
        );

        var isConnected = await NetworkService().getConnectivity();
        if (isConnected) {
          var updatePassword = await _userApi.updatePassword(
            data: updatePasswordForm.value,
          );

          if (updatePassword?.statusCode == 200) {
            // Success
            DialogUtil.showDialogWithOKButton(
              context,
              message: updatePassword?.message ?? Res.string.success,
              barrierDismissible: false,
              callback: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.signIn,
                  (route) => false,
                );
              },
            );
          } else {
            // Error
            Helpers.errorSnackBar(
              context: context,
              title: updatePassword?.message ?? Res.string.apiErrorMessage,
            );
          }
        } else {
          emit(
            state.copyWith(
              authStatus: AuthStatus.failed,
              authMessage: Res.string.youAreInOfflineMode,
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
    } else {
      updatePasswordForm.markAllAsTouched();
    }
  }

  Future<void> _continueWithFirebaseResponse(
    Map firebaseAuthResult,
    String mobileNumber,
  ) async {
    if (firebaseAuthResult.isNotEmpty && firebaseAuthResult['error'] == null) {
      // Firebase auth Success
      emit(
        state.copyWith(
          verificationId: firebaseAuthResult['verificationId'],
          status: VerifyStatus.loaded,
        ),
      );
      pageController.jumpToPage(1);
    } else {
      emit(
        state.copyWith(
          authStatus: AuthStatus.failed,
          authMessage: firebaseAuthResult['error'],
          verificationId: firebaseAuthResult['verificationId'],
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

  Future<void> _verifyOtpOnServer() async {
    try {
      var forgotPasswordResponse = await _userApi.forgotPassword(
        data: forgotPasswordForm.value,
      );

      debugPrint('${forgotPasswordResponse?.toJson()}');

      if (forgotPasswordResponse?.statusCode == 200) {
        // Verify the server generated OTP
        verifyForgetPasswordForm.patchValue(
          {
            ForgotPasswordForm.userIdControl:
                forgotPasswordResponse?.data?.userId,
            ForgotPasswordForm.userOtpControl:
                forgotPasswordResponse?.data?.userOtp,
          },
        );

        var verifyForgotPasswordOTPResponse =
            await _userApi.verifyForgotPasswordOTPResponse(
          data: verifyForgetPasswordForm.value,
        );

        if (verifyForgotPasswordOTPResponse?.statusCode == 200) {
          // Success

          updatePasswordForm.patchValue(
            {
              ForgotPasswordForm.userIdControl:
                  forgotPasswordResponse?.data?.userId,
            },
          );
          emit(
            state.copyWith(
              authStatus: AuthStatus.success,
              authMessage: verifyForgotPasswordOTPResponse?.message ??
                  Res.string.otpVerifiedSuccessfully,
            ),
          );

          pageController.jumpToPage(2);
        } else {
          emit(
            state.copyWith(
              authStatus: AuthStatus.failed,
              authMessage: verifyForgotPasswordOTPResponse?.message ??
                  Res.string.errorVerifyingOtp,
            ),
          );
        }
      } else {
        emit(
          state.copyWith(
            authStatus: AuthStatus.failed,
            authMessage:
                forgotPasswordResponse?.message ?? Res.string.errorSigningUp,
          ),
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
