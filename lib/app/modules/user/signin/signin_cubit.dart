import 'dart:convert';

import 'package:country_picker/country_picker.dart' as country_picker;
import 'package:country_picker/src/utils.dart' as country_picker;
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../configs/configs.dart';
import '../../../../db/db.dart' as db;
import '../../../../resources/resources.dart';
import '../../../../sdk/sdk.dart';
import '../../../app.dart';

part 'signin_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(
    this.context,
  ) : super(const SignInState()) {
    signInForm = AuthForms.signInForm;
    _userApi = UserApi();
    _userStorage = db.UserStorage();

    _initialCountry();
  }

  final BuildContext context;
  late final FormGroup signInForm;
  late final UserApi _userApi;
  late final db.UserStorage _userStorage;

  Future<void> onSignInPressed() async {
    if (signInForm.valid) {
      try {
        emit(
          state.copyWith(
            authStatus: AuthStatus.none,
            status: SignInStatus.signInLoading,
            obscurePassword: true,
          ),
        );
        var isConnected = await NetworkService().getConnectivity();
        if (isConnected) {
          signInForm.patchValue({
            AuthForms.deviceTokenControl: Constants.testDeviceToken,
          });
          debugPrint('${signInForm.value}');

          var response = await _userApi.loginUser(
            userData: signInForm.value,
          );
          debugPrint('${response?.toJson()}');

          if (response?.statusCode == 200 && response?.data != null) {
            if (response?.data?.userStatus == '0' ||
                response?.message == 'User Not Verified') {
              emit(
                state.copyWith(
                  authStatus: AuthStatus.failed,
                  authMessage: response?.message ?? Res.string.userNotVerified,
                ),
              );

              // Navigate to OTP screen
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
              await Future.wait(
                [
                  _userStorage.setUserId(response?.data?.userId),
                  _userStorage.setUserMobile(response?.data?.userMobile),
                  _userStorage.setUserToken(response?.data?.userToken),
                  _userStorage.setUserType(response?.data?.userType),
                  _userStorage.setUserFirstName(response?.data?.firstName),
                  _userStorage.setUserLastName(response?.data?.lastName),
                  _userStorage.setUserDeviceToken(response?.data?.deviceToken),
                  _userStorage.setUserData(jsonEncode(response?.data?.toMap())),
                ],
              );

              emit(
                state.copyWith(
                  authStatus: AuthStatus.success,
                  authMessage:
                      response?.message ?? Res.string.signedInSuccessfully,
                ),
              );

              // Navigate to Dashboard
              // ignore: use_build_context_synchronously
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.dashboard,
                (route) => false,
              );
            }
          } else {
            emit(
              state.copyWith(
                authStatus: AuthStatus.failed,
                authMessage: response?.message ?? Res.string.errorSigningIn,
              ),
            );
          }
        } else {
          emit(
            state.copyWith(
              authStatus: AuthStatus.failed,
              obscurePassword: true,
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
            authMessage: Res.string.errorSigningIn,
          ),
        );
      } finally {
        emit(
          state.copyWith(
            status: SignInStatus.loaded,
          ),
        );
      }
    } else {
      signInForm.markAllAsTouched();
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
        signInForm.control(AuthForms.countryCodeControl) as FormControl;
    var phoneControl =
        signInForm.control(AuthForms.userMobileControl) as FormControl;

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
        signInForm.control(AuthForms.countryCodeControl) as FormControl;
    var phoneControl =
        signInForm.control(AuthForms.userMobileControl) as FormControl;

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
            exampleNumber: value.example.isNotEmpty ? value.example : '',
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

  void forgotPassword() {
    debugPrint('forgot password');
    Navigator.pushNamed(context, Routes.forgotPassword);
  }

  void childMode() {
    debugPrint('child mode');
    Navigator.pushNamed(context, Routes.childMode);
  }

  void signup() {
    debugPrint('sign up');
    Navigator.pushNamed(context, Routes.signUp);
  }
}
