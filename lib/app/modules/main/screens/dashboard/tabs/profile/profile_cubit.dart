// ignore_for_file: implementation_imports

import 'dart:convert';

import 'package:country_picker/country_picker.dart' as country_picker;
import 'package:country_picker/src/utils.dart' as country_picker;
import 'package:country_picker/src/res/country_codes.dart' as country_picker;
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../../../../db/db.dart';
import '../../../../../../../resources/resources.dart';
import '../../../../../../app.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(
    this.context,
  ) : super(const ProfileState()) {
    profileForm = ProfileForms.profileForm;
    _userStorage = UserStorage();

    _getThemeMode();
    _initialCountry();
    getProfileDetails();
  }

  final BuildContext context;
  late final FormGroup profileForm;
  late UserStorage _userStorage;
  late bool darkMode;

  _getThemeMode() {
    darkMode = Res.appTheme.getThemeMode() == ThemeMode.dark;
  }

  void _initialCountry() {
    var countryCodeControl =
        profileForm.control(ProfileForms.countryCodeControl) as FormControl;
    var phoneControl =
        profileForm.control(ProfileForms.mobileNumberControl) as FormControl;

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
        profileForm.control(ProfileForms.countryCodeControl) as FormControl;
    var phoneControl =
        profileForm.control(ProfileForms.mobileNumberControl) as FormControl;

    country_picker.showCountryPicker(
      context: context,
      showPhoneCode: true,
      countryListTheme: country_picker.CountryListThemeData(
        borderRadius: BorderRadius.circular(20.0),
        backgroundColor: darkMode
            ? Res.colors.backgroundColorDark
            : Res.colors.backgroundColorLight,
        bottomSheetHeight: MediaQuery.of(context).size.height / 1.5,
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

  Future<void> getProfileDetails() async {
    try {
      String? userData = _userStorage.getUserData();
      if (userData != null) {
        var userMap = jsonDecode(userData);

        emit(
          state.copyWith(
            profileImage: userMap['profile_img'],
          ),
        );

        profileForm.patchValue(userMap);

        var userCountryCode = userMap[ProfileForms.countryCodeControl]
            .toString()
            .replaceAll('+', '');

        country_picker.Country? country;
        for (var countryCode in country_picker.countryCodes) {
          if (countryCode['e164_cc'] == userCountryCode) {
            country = country_picker.Country.tryParse(countryCode['name']);
            break;
          }
        }

        if (country != null) {
          debugPrint('$country');

          emit(
            state.copyWith(
              countryCode: '+${country.phoneCode}',
              flag:
                  country_picker.Utils.countryCodeToEmoji(country.countryCode),
              maxLength:
                  country.example.isNotEmpty ? country.example.length : null,
              hint: country.example,
              exampleNumber: country.example,
            ),
          );
        }
      }
    } catch (e) {
      debugPrint('Unable to fetch user details ${e.toString()}');
    }
  }
}
