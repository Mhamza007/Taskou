import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart' as forms;

import '../../../../resources/resources.dart';
import '../../../app.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var darkMode = Res.appTheme.getThemeMode() == ThemeMode.dark;

    return BlocProvider(
      create: (context) => SignUpCubit(context),
      child: Scaffold(
        body: BlocConsumer<SignUpCubit, SignUpState>(
          listenWhen: (prev, curr) => prev.authStatus != curr.authStatus,
          listener: (context, state) {
            switch (state.authStatus) {
              case AuthStatus.success:
                Helpers.successSnackBar(
                  context: context,
                  title: state.authMessage,
                );
                break;
              case AuthStatus.failed:
                Helpers.errorSnackBar(
                  context: context,
                  title: state.authMessage,
                );
                break;
              default:
            }
          },
          builder: (context, state) {
            var signUpCubit = context.read<SignUpCubit>();
            return AbsorbPointer(
              absorbing: state.status == SignUpStatus.signUpLoading,
              child: GestureDetector(
                onTap: signUpCubit.signUpForm.unfocus,
                child: SafeArea(
                  child: forms.ReactiveForm(
                    formGroup: signUpCubit.signUpForm,
                    child: ScrollConfiguration(
                      behavior: const ScrollBehavior().copyWith(
                        overscroll: false,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const SizedBox(height: 24),
                            SvgPicture.asset(
                              darkMode
                                  ? Res.drawable.appLogoDark
                                  : Res.drawable.appLogo,
                            ).paddingSymmetric(horizontal: 20),
                            const SizedBox(height: 32),

                            /// Phone Number field
                            ReactivePhoneNumberField(
                              countryCodeControlName:
                                  AuthForms.countryCodeControl,
                              phoneNumberControlName:
                                  AuthForms.contactPhoneControl,
                              flag: state.flag,
                              hint: Res.string.phoneNumber,
                              maxLength: state.maxLength,
                              title: Res.string.phoneNumber,
                              pickCountry: (p0) {
                                signUpCubit.selectCountry(context);
                              },
                              darkMode: darkMode,
                            ).paddingOnly(bottom: 16),

                            /// Last Name field
                            ReactiveTextField(
                              formControlName: AuthForms.lastNameControl,
                              hint: Res.string.enterLastName,
                              keyboardType: TextInputType.name,
                              inputAction: TextInputAction.next,
                              validationMessages: {
                                forms.ValidationMessage.required: (_) =>
                                    Res.string.thisFieldIsRequired,
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-z A-Z ]'),
                                )
                              ],
                              widgetAboveField: Text(
                                Res.string.lastName,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                ),
                              ).marginOnly(bottom: 8),
                              suffixWidget: SvgPicture.asset(
                                Res.drawable.user,
                                height: 24,
                                width: 24,
                                fit: BoxFit.scaleDown,
                                color: darkMode
                                    ? Res.colors.textColorDark
                                    : Res.colors.textColor,
                              ),
                            ).paddingOnly(bottom: 16),

                            /// Last Name field
                            ReactiveTextField(
                              formControlName: AuthForms.firstNameControl,
                              hint: Res.string.enterFirstName,
                              keyboardType: TextInputType.name,
                              inputAction: TextInputAction.next,
                              validationMessages: {
                                forms.ValidationMessage.required: (_) =>
                                    Res.string.thisFieldIsRequired,
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[a-z A-Z ]'))
                              ],
                              widgetAboveField: Text(
                                Res.string.firstName,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                ),
                              ).marginOnly(bottom: 8),
                              suffixWidget: SvgPicture.asset(
                                Res.drawable.user,
                                height: 24,
                                width: 24,
                                fit: BoxFit.scaleDown,
                                color: darkMode
                                    ? Res.colors.textColorDark
                                    : Res.colors.textColor,
                              ),
                            ).paddingOnly(bottom: 16),

                            /// Password field
                            ReactiveTextField(
                              formControlName: AuthForms.passwordControl,
                              hint: Res.string.enterPassword,
                              keyboardType: TextInputType.visiblePassword,
                              inputAction: TextInputAction.go,
                              validationMessages: {
                                forms.ValidationMessage.required: (_) =>
                                    Res.string.thisFieldIsRequired,
                              },
                              widgetAboveField: Text(
                                Res.string.password,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                ),
                              ).marginOnly(bottom: 8),
                              obscureText: state.obscurePassword,
                              suffixWidget: SvgPicture.asset(
                                Res.drawable.password,
                                height: 24,
                                width: 24,
                                fit: BoxFit.scaleDown,
                                color: darkMode
                                    ? Res.colors.textColorDark
                                    : Res.colors.textColor,
                              ),
                            ).paddingOnly(bottom: 16),

                            /// Email field
                            ReactiveTextField(
                              formControlName: AuthForms.emailControl,
                              hint: Res.string.enterEmail,
                              keyboardType: TextInputType.emailAddress,
                              inputAction: TextInputAction.next,
                              validationMessages: {
                                forms.ValidationMessage.email: (_) =>
                                    'Invalid Email Address',
                              },
                              widgetAboveField: Text(
                                Res.string.emailOptional,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                ),
                              ).marginOnly(bottom: 8),
                              suffixWidget: SvgPicture.asset(
                                Res.drawable.email,
                                height: 24,
                                width: 24,
                                fit: BoxFit.scaleDown,
                                color: darkMode
                                    ? Res.colors.textColorDark
                                    : Res.colors.textColor,
                              ),
                            ).paddingOnly(bottom: 16),

                            /// City field
                            ReactiveTextField(
                              formControlName: AuthForms.cityControl,
                              hint: Res.string.enterCity,
                              keyboardType: TextInputType.text,
                              inputAction: TextInputAction.next,
                              validationMessages: {
                                forms.ValidationMessage.required: (_) =>
                                    Res.string.thisFieldIsRequired,
                              },
                              widgetAboveField: Text(
                                Res.string.city,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                ),
                              ).marginOnly(bottom: 8),
                              suffixWidget: SvgPicture.asset(
                                Res.drawable.location,
                                height: 24,
                                width: 24,
                                fit: BoxFit.scaleDown,
                                color: darkMode
                                    ? Res.colors.textColorDark
                                    : Res.colors.textColor,
                              ),
                            ).paddingOnly(bottom: 16),

                            /// Province field
                            ReactiveTextField(
                              formControlName: AuthForms.provinceControl,
                              hint: Res.string.enterProvince,
                              keyboardType: TextInputType.text,
                              inputAction: TextInputAction.next,
                              validationMessages: {
                                forms.ValidationMessage.required: (_) =>
                                    Res.string.thisFieldIsRequired,
                              },
                              widgetAboveField: Text(
                                Res.string.province,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              suffixWidget: SvgPicture.asset(
                                Res.drawable.location,
                                height: 24,
                                width: 24,
                                fit: BoxFit.scaleDown,
                                color: darkMode
                                    ? Res.colors.textColorDark
                                    : Res.colors.textColor,
                              ).marginOnly(bottom: 8),
                            ).paddingOnly(bottom: 16),

                            /// Zip Code field
                            ReactiveTextField(
                              formControlName: AuthForms.zipCodeControl,
                              hint: Res.string.enterZipCode,
                              keyboardType: TextInputType.text,
                              inputAction: TextInputAction.next,
                              validationMessages: {
                                forms.ValidationMessage.required: (_) =>
                                    Res.string.thisFieldIsRequired,
                              },
                              widgetAboveField: Text(
                                Res.string.zipCode,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                ),
                              ).marginOnly(bottom: 8),
                              suffixWidget: SvgPicture.asset(
                                Res.drawable.zip,
                                height: 24,
                                width: 24,
                                fit: BoxFit.scaleDown,
                                color: darkMode
                                    ? Res.colors.textColorDark
                                    : Res.colors.textColor,
                              ),
                            ).paddingOnly(bottom: 16),

                            /// Price per hour
                            ReactiveTextField(
                              formControlName: AuthForms.pricePerHourControl,
                              hint: Res.string.price,
                              keyboardType: TextInputType.text,
                              inputAction: TextInputAction.next,
                              validationMessages: {
                                forms.ValidationMessage.required: (_) =>
                                    Res.string.thisFieldIsRequired,
                              },
                              widgetAboveField: Text(
                                Res.string.pricePerHour,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                ),
                              ).marginOnly(bottom: 8),
                              suffixWidget: SvgPicture.asset(
                                Res.drawable.pricePerHour,
                                height: 24,
                                width: 24,
                                fit: BoxFit.scaleDown,
                                color: darkMode
                                    ? Res.colors.textColorDark
                                    : Res.colors.textColor,
                              ),
                            ).paddingOnly(bottom: 16),
                            Center(
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          '${Res.string.bySigningUpYouAgreeToOur}\n',
                                      style: DefaultTextStyle.of(context)
                                          .style
                                          .copyWith(
                                            fontSize: 16,
                                          ),
                                    ),
                                    TextSpan(
                                      text: Res.string.termsConditions,
                                      style: TextStyle(
                                        color: Res.colors.materialColor,
                                        fontSize: 12,
                                        decoration: TextDecoration.underline,
                                        decorationColor:
                                            Res.colors.materialColor,
                                        decorationThickness: 2,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' ${Res.string.and} ',
                                      style: DefaultTextStyle.of(context)
                                          .style
                                          .copyWith(
                                            fontSize: 12,
                                          ),
                                    ),
                                    TextSpan(
                                      text: 'Privacy Policy',
                                      style: TextStyle(
                                        color: Res.colors.materialColor,
                                        fontSize: 12,
                                        decoration: TextDecoration.underline,
                                        decorationColor:
                                            Res.colors.materialColor,
                                        decorationThickness: 2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ).paddingOnly(bottom: 16),
                            const SizedBox(height: 16),
                            Center(
                              child: ElevatedButton(
                                onPressed: signUpCubit.onSignUpPressed,
                                style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0.0),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                  ),
                                ),
                                child:
                                    state.status == SignUpStatus.signUpLoading
                                        ? const SizedBox(
                                            height: 28,
                                            width: 28,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                          ).paddingSymmetric(
                                            vertical: 12,
                                            horizontal: 64,
                                          )
                                        : Text(
                                            Res.string.register,
                                            style: TextStyle(
                                              color: Res.colors.whiteColor,
                                              fontSize: 24.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ).paddingSymmetric(
                                            vertical: 12,
                                            horizontal: 32,
                                          ),
                              ),
                            ).paddingOnly(bottom: 16),
                            const SizedBox(height: 16),
                            Center(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: Res.string.alreadyHaveAnAccount,
                                      style: DefaultTextStyle.of(context).style,
                                    ),
                                    const TextSpan(text: '  '),
                                    TextSpan(
                                      text: Res.string.signin,
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Res.colors.materialColor,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = signUpCubit.signin,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ).paddingSymmetric(
                          vertical: 16,
                          horizontal: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
