import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart' as forms;

import '../../../../resources/resources.dart';
import '../../../app.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var darkMode = Res.appTheme.getThemeMode() == ThemeMode.dark;

    return BlocProvider(
      create: (context) => SignInCubit(context),
      child: Scaffold(
        body: BlocConsumer<SignInCubit, SignInState>(
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
            var signInCubit = context.read<SignInCubit>();
            return AbsorbPointer(
              absorbing: state.status == SignInStatus.signInLoading,
              child: GestureDetector(
                onTap: signInCubit.signInForm.unfocus,
                child: SafeArea(
                  child: forms.ReactiveForm(
                    formGroup: signInCubit.signInForm,
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
                          countryCodeControlName: AuthForms.countryCodeControl,
                          phoneNumberControlName: AuthForms.userMobileControl,
                          flag: state.flag,
                          hint: Res.string.phoneNumber,
                          maxLength: state.maxLength,
                          title: Res.string.phoneNumber,
                          pickCountry: (p0) {
                            signInCubit.selectCountry(context);
                          },
                          darkMode: darkMode,
                        ).paddingOnly(
                          bottom: 16,
                        ),

                        /// Password field
                        ReactiveTextField(
                          formControlName: AuthForms.passwordControl,
                          hint: Res.string.password,
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
                            Res.drawable.lock,
                            height: 24,
                            width: 24,
                            fit: BoxFit.scaleDown,
                            color: darkMode
                                ? Res.colors.textColorDark
                                : Res.colors.textColor,
                          ),
                        ).paddingOnly(
                          bottom: 16,
                        ),

                        // Forgot Password
                        SizedBox(
                          width: double.maxFinite,
                          child: Text(
                            Res.string.forgotPassword,
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        )
                            .onTap(signInCubit.forgotPassword)
                            .paddingOnly(bottom: 16),

                        // Sign in button
                        Center(
                          child: ElevatedButton(
                            onPressed: signInCubit.onSignInPressed,
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0.0),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                              ),
                            ),
                            child: state.status == SignInStatus.signInLoading
                                ? const SizedBox(
                                    height: 28,
                                    width: 28,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ).paddingSymmetric(
                                    vertical: 12,
                                    horizontal: 48,
                                  )
                                : Text(
                                    Res.string.login,
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

                        // Child Mode
                        Center(
                          child: Text(
                            Res.string.childMode,
                            style: const TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ).onTap(
                            signInCubit.childMode,
                          ),
                        ).paddingOnly(bottom: 16),
                        const Spacer(),

                        // Sign up
                        Center(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: Res.string.dontHaveAnAccount,
                                ),
                                const TextSpan(text: '  '),
                                TextSpan(
                                  text: Res.string.signup,
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Res.colors.materialColor,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = signInCubit.signup,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ).paddingSymmetric(
                      vertical: 16,
                      horizontal: 24,
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
