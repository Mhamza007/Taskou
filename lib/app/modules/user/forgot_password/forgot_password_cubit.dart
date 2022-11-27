import 'package:country_picker/country_picker.dart' as country_picker;
import 'package:country_picker/src/utils.dart' as country_picker;
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../app.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit(this.context) : super(const ForgotPasswordState()) {
    forgotPasswordForm = AuthForms.forgotPasswordForm;

    _initialCountry();
  }

  final BuildContext context;
  late final FormGroup forgotPasswordForm;

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

  Future<void> onSendButtonPressed() async {}
}
