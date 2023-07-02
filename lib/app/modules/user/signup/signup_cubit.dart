import 'package:country_picker/country_picker.dart' as country_picker;
import 'package:country_picker/src/utils.dart' as country_picker;
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../configs/configs.dart';
import '../../../../resources/resources.dart';
import '../../../../sdk/sdk.dart';
import '../../../app.dart';

part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(
    this.context,
  ) : super(const SignUpState()) {
    signUpForm = AuthForms.signUpForm;
    _userApi = UserApi();
    _authService = AuthService();

    _initialCountry();
  }

  final BuildContext context;
  late final FormGroup signUpForm;
  late final UserApi _userApi;
  late final AuthService _authService;

  Future<void> onSignUpPressed() async {
    if (signUpForm.valid) {
      Helpers.unFocus();
      try {
        emit(
          state.copyWith(
            authStatus: AuthStatus.none,
            status: SignUpStatus.signUpLoading,
            obscurePassword: true,
          ),
        );
        var isConnected = await NetworkService().getConnectivity();
        if (isConnected) {
          signUpForm.patchValue({
            AuthForms.deviceTokenControl: Constants.testDeviceToken,
          });
          debugPrint('${signUpForm.value}');

          // Firebase Auth
          var countryCode = signUpForm
              .control(
                AuthForms.countryCodeControl,
              )
              .value;
          var contactNumber = signUpForm
              .control(
                AuthForms.contactPhoneControl,
              )
              .value;

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
          //         status: SignUpStatus.loaded,
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

          var response = await _userApi.signUpUser(
            userData: signUpForm.value,
          );
          debugPrint('${response?.toJson()}');

          if (response?.statusCode == 200) {
            emit(
              state.copyWith(
                authStatus: AuthStatus.success,
                authMessage: response?.message ?? Res.string.signUpSuccessful,
              ),
            );

            // ignore: use_build_context_synchronously
            Navigator.pushNamed(
              context,
              Routes.otp,
              arguments: {
                'user_id': response?.data?.userId,
                'mobile': response?.data?.userMobile,
                'otp': response?.data?.userOtp,
              },
            );
          } else {
            emit(
              state.copyWith(
                authStatus: AuthStatus.failed,
                authMessage:
                    response?.message ?? 'Error occurred while signing up',
              ),
            );
          }
        } else {
          emit(
            state.copyWith(
              authStatus: AuthStatus.failed,
              obscurePassword: true,
              authMessage: Res.string.youAreInOfflineMode,
              status: SignUpStatus.loaded,
            ),
          );
        }
      } on NetworkException catch (e) {
        emit(
          state.copyWith(
            authStatus: AuthStatus.failed,
            authMessage: e.toString(),
            status: SignUpStatus.loaded,
          ),
        );
      } on ResponseException catch (e) {
        emit(
          state.copyWith(
            authStatus: AuthStatus.failed,
            authMessage: e.toString(),
            status: SignUpStatus.loaded,
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            authStatus: AuthStatus.failed,
            authMessage: Res.string.errorSigningUp,
            status: SignUpStatus.loaded,
          ),
        );
        // } finally {
        //   emit(
        //     state.copyWith(
        //       status: SignUpStatus.loaded,
        //     ),
        //   );
      }
    } else {
      signUpForm.markAllAsTouched();
    }
  }

  void togglePasswordVisibility() {
    emit(
      state.copyWith(
        obscurePassword: !state.obscurePassword,
      ),
    );
  }

  void _initialCountry() {
    var countryCodeControl =
        signUpForm.control(AuthForms.countryCodeControl) as FormControl;
    var phoneControl =
        signUpForm.control(AuthForms.contactPhoneControl) as FormControl;

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
        exampleNumber: country.example,
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

  void selectCountry(BuildContext context) {
    var countryCodeControl =
        signUpForm.control(AuthForms.countryCodeControl) as FormControl;
    var phoneControl =
        signUpForm.control(AuthForms.contactPhoneControl) as FormControl;

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
            exampleNumber: value.example,
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
    return (signUpForm.control(AuthForms.userMobileControl) as FormControl)
            .value
            .toString()
            .length ==
        state.exampleNumber?.length;
  }

  void signin() {
    debugPrint('sign in');
    Navigator.pushNamedAndRemoveUntil(context, Routes.signIn, (route) => false);
  }

  Future<void> _continueWithFirebaseResponse(
    Map firebaseAuthResult,
    String mobileNumber,
  ) async {
    if (firebaseAuthResult.isNotEmpty && firebaseAuthResult['error'] == null) {
      // Success

      // ignore: use_build_context_synchronously
      Navigator.pushNamed(
        context,
        Routes.otp,
        arguments: {
          'user_data': signUpForm.value,
          'verification_id': firebaseAuthResult['verificationId'],
          'phone_number': mobileNumber,
        },
      );
    } else {
      emit(
        state.copyWith(
          authStatus: AuthStatus.failed,
          authMessage: firebaseAuthResult['error'],
          status: SignUpStatus.loaded,
        ),
      );
    }
  }
}
