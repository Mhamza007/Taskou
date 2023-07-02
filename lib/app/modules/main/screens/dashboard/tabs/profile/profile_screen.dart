import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart' as forms;

import '../../../../../../../resources/resources.dart';
import '../../../../../../app.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required this.cubit,
    required this.state,
    this.themeMode,
    this.editMode = false,
    this.saveProfile,
  });

  final ProfileCubit cubit;
  final ProfileState state;
  final ThemeMode? themeMode;
  final bool editMode;
  final Function()? saveProfile;

  @override
  Widget build(BuildContext context) {
    bool darkMode = themeMode == ThemeMode.dark;

    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(
        overscroll: false,
      ),
      child: forms.ReactiveForm(
        formGroup: cubit.profileForm,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            CircleAvatar(
              radius: 60.0,
              child:
                  state.profileImage != null && state.profileImage!.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: CachedNetworkImage(
                            imageUrl: state.profileImage!,
                            height: 120,
                            width: 120,
                            errorWidget: (context, url, error) =>
                                const SizedBox.shrink(),
                          ),
                        )
                      : const SizedBox.shrink(),
            ),

            /// Phone Number field
            ReactivePhoneNumberField(
              countryCodeControlName: ProfileForms.countryCodeControl,
              phoneNumberControlName: ProfileForms.mobileNumberControl,
              flag: state.flag,
              hint: Res.string.phoneNumber,
              maxLength: state.maxLength,
              title: Res.string.phoneNumber,
              readOnly: !editMode,
              pickCountry: editMode
                  ? (p0) {
                      cubit.selectCountry(context);
                    }
                  : null,
              showSuffix: false,
              darkMode: darkMode,
            ).paddingOnly(bottom: 16),

            /// Last Name field
            ReactiveTextField(
              formControlName: ProfileForms.lastNameControl,
              hint: Res.string.enterLastName,
              keyboardType: TextInputType.name,
              inputAction: TextInputAction.next,
              readOnly: !editMode,
              validationMessages: {
                forms.ValidationMessage.required: (_) =>
                    Res.string.thisFieldIsRequired,
              },
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-z A-Z ]'))
              ],
              widgetAboveField: Text(
                Res.string.lastName,
                style: TextStyle(
                  fontSize: 18.0,
                  color: darkMode
                      ? Res.colors.textColorDark
                      : Res.colors.textColor,
                ),
              ).marginOnly(bottom: 8.0),
              suffixWidget: const SizedBox.shrink(),
              darkMode: darkMode,
            ).paddingOnly(bottom: 16),

            /// First Name field
            ReactiveTextField(
              formControlName: ProfileForms.firstNameControl,
              hint: Res.string.enterFirstName,
              keyboardType: TextInputType.name,
              inputAction: TextInputAction.next,
              readOnly: !editMode,
              validationMessages: {
                forms.ValidationMessage.required: (_) =>
                    Res.string.thisFieldIsRequired,
              },
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-z A-Z ]'))
              ],
              widgetAboveField: Text(
                Res.string.firstName,
                style: TextStyle(
                  fontSize: 18.0,
                  color: darkMode
                      ? Res.colors.textColorDark
                      : Res.colors.textColor,
                ),
              ).marginOnly(bottom: 8.0),
              suffixWidget: const SizedBox.shrink(),
              darkMode: darkMode,
            ).paddingOnly(bottom: 16),

            /// Email field
            ReactiveTextField(
              formControlName: ProfileForms.emailControl,
              hint: Res.string.enterEmail,
              keyboardType: TextInputType.emailAddress,
              inputAction: TextInputAction.next,
              readOnly: !editMode,
              validationMessages: {
                forms.ValidationMessage.email: (_) => 'Invalid Email Address',
              },
              widgetAboveField: Text(
                Res.string.email,
                style: TextStyle(
                  fontSize: 18.0,
                  color: darkMode
                      ? Res.colors.textColorDark
                      : Res.colors.textColor,
                ),
              ).marginOnly(bottom: 8.0),
              suffixWidget: const SizedBox.shrink(),
              darkMode: darkMode,
            ).paddingOnly(bottom: 16),

            /// City field
            ReactiveTextField(
              formControlName: ProfileForms.cityControl,
              hint: Res.string.enterCity,
              keyboardType: TextInputType.text,
              inputAction: TextInputAction.next,
              readOnly: !editMode,
              validationMessages: {
                forms.ValidationMessage.required: (_) =>
                    Res.string.thisFieldIsRequired,
              },
              widgetAboveField: Text(
                Res.string.city,
                style: TextStyle(
                  fontSize: 18.0,
                  color: darkMode
                      ? Res.colors.textColorDark
                      : Res.colors.textColor,
                ),
              ).marginOnly(bottom: 8.0),
              suffixWidget: const SizedBox.shrink(),
              darkMode: darkMode,
            ).paddingOnly(bottom: 16),

            /// Province field
            ReactiveTextField(
              formControlName: ProfileForms.provinceControl,
              hint: Res.string.enterProvince,
              keyboardType: TextInputType.text,
              inputAction: TextInputAction.next,
              readOnly: !editMode,
              validationMessages: {
                forms.ValidationMessage.required: (_) =>
                    Res.string.thisFieldIsRequired,
              },
              widgetAboveField: Text(
                Res.string.province,
                style: TextStyle(
                  fontSize: 18.0,
                  color: darkMode
                      ? Res.colors.textColorDark
                      : Res.colors.textColor,
                ),
              ).marginOnly(bottom: 8.0),
              suffixWidget: const SizedBox.shrink(),
              darkMode: darkMode,
            ).paddingOnly(bottom: 16),

            /// Zip Code field
            ReactiveTextField(
              formControlName: ProfileForms.zipCodeControl,
              hint: Res.string.enterZipCode,
              keyboardType: TextInputType.text,
              inputAction: TextInputAction.next,
              readOnly: !editMode,
              validationMessages: {
                forms.ValidationMessage.required: (_) =>
                    Res.string.thisFieldIsRequired,
              },
              widgetAboveField: Text(
                Res.string.zipCode,
                style: TextStyle(
                  fontSize: 18.0,
                  color: darkMode
                      ? Res.colors.textColorDark
                      : Res.colors.textColor,
                ),
              ).marginOnly(bottom: 8.0),
              suffixWidget: const SizedBox.shrink(),
              darkMode: darkMode,
            ).paddingOnly(bottom: 16),

            /// Save Button
            if (editMode)
              ElevatedButton(
                onPressed: saveProfile,
                child: state.loading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Res.colors.whiteColor,
                        ),
                      ).marginSymmetric(
                        vertical: 6.0,
                      )
                    : Text(
                        Res.string.save,
                      ).marginSymmetric(
                        vertical: 16.0,
                      ),
              ),
          ],
        ),
      ),
    );
  }
}
