import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
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
            var forgotPasswordCubit = context.read<ForgotPasswordCubit>();
            return SafeArea(
              child: GestureDetector(
                onTap: forgotPasswordCubit.forgotPasswordForm.unfocus,
                child: forms.ReactiveForm(
                  formGroup: forgotPasswordCubit.forgotPasswordForm,
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

                          // Phone Number field
                          ReactivePhoneNumberField(
                            countryCodeControlName:
                                AuthForms.countryCodeControl,
                            phoneNumberControlName: AuthForms.userMobileControl,
                            flag: state.flag,
                            hint: Res.string.phoneNumber,
                            maxLength: state.maxLength,
                            title: Res.string.phoneNumber,
                            pickCountry: (p0) {
                              forgotPasswordCubit.selectCountry();
                            },
                          ).paddingOnly(
                            bottom: 16,
                          ),
                          const SizedBox(height: 32),
                          SizedBox(
                            width: double.maxFinite,
                            child: ElevatedButton(
                              onPressed:
                                  forgotPasswordCubit.onSendButtonPressed,
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0.0),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                ),
                              ),
                              child: Text(
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
                          )
                        ],
                      ).paddingSymmetric(
                        vertical: 16,
                        horizontal: 24,
                      ),
                      Positioned(
                        top: 12,
                        left: 12,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(
                            Icons.arrow_back,
                          ),
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
}
