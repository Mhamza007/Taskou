import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:reactive_forms/reactive_forms.dart' as forms;

import '../../../../resources/resources.dart';
import '../../../app.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordCubit(context),
      child: Scaffold(
        body: BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
          builder: (context, state) {
            var cubit = context.read<ForgotPasswordCubit>();
            return SafeArea(
              child: GestureDetector(
                onTap: cubit.forgotPasswordForm.unfocus,
                child: forms.ReactiveForm(
                  formGroup: cubit.forgotPasswordForm,
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const SizedBox(height: 40),
                          SvgPicture.asset(
                            Res.drawable.appLogo,
                          ).paddingSymmetric(horizontal: 20),
                          const SizedBox(height: 32),
                          Expanded(
                            child: PageView(
                              physics: const NeverScrollableScrollPhysics(),
                              controller: cubit.pageController,
                              children: [
                                // Step 1 - Enter Phone number
                                _phoneNumberWidget(
                                  cubit,
                                  state,
                                ),

                                // Step 2 - OTP
                                _forgetPasswordOtpWidget(
                                  cubit,
                                  state,
                                ),

                                // Step 3 - Verify
                                _confirmPasswordWidget(
                                  cubit,
                                  state,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ).paddingSymmetric(
                        vertical: 16,
                        horizontal: 24,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _phoneNumberWidget(
    ForgotPasswordCubit cubit,
    ForgotPasswordState state,
  ) {
    return forms.ReactiveForm(
      formGroup: cubit.forgotPasswordForm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          // Phone Number field
          ReactivePhoneNumberField(
            countryCodeControlName: ForgotPasswordForm.countryCodeControl,
            phoneNumberControlName: ForgotPasswordForm.userMobileControl,
            flag: state.flag,
            hint: Res.string.phoneNumber,
            maxLength: state.maxLength,
            title: Res.string.phoneNumber,
            pickCountry: (p0) {
              cubit.selectCountry();
            },
          ).paddingOnly(
            bottom: 16,
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.maxFinite,
            child: ElevatedButton(
              onPressed: cubit.onSendButtonPressed,
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0.0),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ),
              child: state.status == VerifyStatus.loading
                  ? Center(
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                      ).paddingSymmetric(
                        vertical: 8,
                      ),
                    )
                  : Text(
                      Res.string.send,
                      style: TextStyle(
                        color: Res.colors.whiteColor,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ).paddingSymmetric(
                      vertical: 12,
                      horizontal: 24,
                    ),
            ),
          ),
        ],
      ).paddingSymmetric(
        vertical: 16,
        horizontal: 24,
      ),
    );
  }

  Widget _forgetPasswordOtpWidget(
    ForgotPasswordCubit cubit,
    ForgotPasswordState state,
  ) {
    var darkMode = Res.appTheme.getThemeMode() == ThemeMode.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 52),
      padding: const EdgeInsets.all(16.0),
      width: double.maxFinite,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 60.0,
            child: SvgPicture.asset(
              Res.drawable.otp,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            Res.string.otp,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Pinput(
                  controller: cubit.pinController,
                  length: 4,
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  defaultPinTheme: PinTheme(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: darkMode ? Colors.white : Colors.black,
                          width: 4.0,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.all(20.0),
                    textStyle: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.maxFinite,
            child: ElevatedButton(
              onPressed: cubit.verifyOtp,
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0.0),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(
                  Res.colors.materialColor,
                ),
              ),
              child: state.status == VerifyStatus.loading
                  ? Center(
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                      ).paddingSymmetric(
                        vertical: 8,
                      ),
                    )
                  : Text(
                      Res.string.verify,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ).paddingSymmetric(
                      vertical: 12.0,
                      horizontal: 24,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _confirmPasswordWidget(
    ForgotPasswordCubit cubit,
    ForgotPasswordState state,
  ) {
    var darkMode = Res.appTheme.getThemeMode() == ThemeMode.dark;

    return forms.ReactiveForm(
      formGroup: cubit.updatePasswordForm,
      child: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(
          overscroll: false,
        ),
        child: ListView(
          children: [
            ReactiveTextField(
              formControlName: ForgotPasswordForm.passwordControl,
              hint: Res.string.password,
              keyboardType: TextInputType.visiblePassword,
              inputAction: TextInputAction.next,
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
              obscureText: true,
              suffixWidget: SvgPicture.asset(
                Res.drawable.lock,
                height: 24,
                width: 24,
                fit: BoxFit.scaleDown,
                color:
                    darkMode ? Res.colors.textColorDark : Res.colors.textColor,
              ),
            ).paddingOnly(
              bottom: 16,
            ),
            ReactiveTextField(
              formControlName: ForgotPasswordForm.confirmPasswordControl,
              hint: Res.string.confirmPassword,
              keyboardType: TextInputType.visiblePassword,
              inputAction: TextInputAction.next,
              validationMessages: {
                forms.ValidationMessage.required: (_) =>
                    Res.string.thisFieldIsRequired,
                forms.ValidationMessage.mustMatch: (_) =>
                    Res.string.newConfirmPasswordNotMatched
              },
              widgetAboveField: Text(
                Res.string.confirmPassword,
                style: const TextStyle(
                  fontSize: 18.0,
                ),
              ).marginOnly(bottom: 8),
              obscureText: true,
              suffixWidget: SvgPicture.asset(
                Res.drawable.lock,
                height: 24,
                width: 24,
                fit: BoxFit.scaleDown,
                color:
                    darkMode ? Res.colors.textColorDark : Res.colors.textColor,
              ),
            ).paddingOnly(
              bottom: 16,
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: state.status == VerifyStatus.loading
                  ? null
                  : cubit.confirmPassword,
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0.0),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                fixedSize: MaterialStateProperty.all(
                  const Size(
                    double.maxFinite,
                    60.0,
                  ),
                ),
              ),
              child: state.status == VerifyStatus.loading
                  ? SizedBox(
                      height: 28,
                      width: 28,
                      child: CircularProgressIndicator(
                        color: Res.colors.materialColor,
                      ),
                    ).paddingSymmetric(
                      vertical: 12,
                      horizontal: 48,
                    )
                  : Text(
                      Res.string.confirmPassword,
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
          ],
        ).paddingSymmetric(
          vertical: 16,
          horizontal: 24,
        ),
      ),
    );
  }
}
