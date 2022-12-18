import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart' as forms;

import '../../../../resources/resources.dart';
import '../../../app.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var darkMode = Res.appTheme.getThemeMode() == ThemeMode.dark;

    return BlocProvider(
      create: (context) => ChangePasswordCubit(context),
      child: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
        listenWhen: (prev, curr) =>
            prev.apiResponseStatus != curr.apiResponseStatus,
        listener: (context, state) {
          switch (state.apiResponseStatus) {
            case ApiResponseStatus.success:
              showCupertinoDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: Text(
                      Res.string.appTitle.toUpperCase(),
                      style: TextStyle(
                        color: Res.colors.materialColor,
                      ),
                    ),
                    content: Text(state.message),
                    actions: [
                      CupertinoDialogAction(
                        child: Text(
                          Res.string.ok,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              );
              break;
            case ApiResponseStatus.failure:
              Helpers.errorSnackBar(
                context: context,
                title: state.message,
              );
              break;
            default:
          }
        },
        builder: (context, state) {
          var cubit = context.read<ChangePasswordCubit>();

          return AbsorbPointer(
            absorbing: state.loading,
            child: Scaffold(
              appBar: AppBar(
                leading: InkWell(
                  onTap: cubit.back,
                  child: SvgPicture.asset(
                    Res.drawable.back,
                    width: 24,
                    height: 24,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                title: Text(Res.string.changePassword),
              ),
              body: GestureDetector(
                onTap: cubit.forgotPasswordForm.unfocus,
                child: forms.ReactiveForm(
                  formGroup: cubit.forgotPasswordForm,
                  child: ListView(
                    padding: const EdgeInsets.all(24.0),
                    children: [
                      /// Old Password field
                      ReactiveTextField(
                        formControlName: ForgotPasswordForm.oldPasswordControl,
                        hint: Res.string.enterOldPassword,
                        keyboardType: TextInputType.visiblePassword,
                        inputAction: TextInputAction.next,
                        validationMessages: {
                          forms.ValidationMessage.required: (_) =>
                              Res.string.thisFieldIsRequired,
                        },
                        widgetAboveField: Text(
                          Res.string.oldPassword,
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
                          color: darkMode
                              ? Res.colors.textColorDark
                              : Res.colors.textColor,
                        ),
                      ).paddingOnly(
                        bottom: 16,
                      ),

                      /// New Password field
                      ReactiveTextField(
                        formControlName: ForgotPasswordForm.newPasswordControl,
                        hint: Res.string.enterNewPassword,
                        keyboardType: TextInputType.visiblePassword,
                        inputAction: TextInputAction.next,
                        validationMessages: {
                          forms.ValidationMessage.required: (_) =>
                              Res.string.thisFieldIsRequired,
                          forms.ValidationMessage.minLength: (_) =>
                              Res.string.passwordLengthError,
                        },
                        widgetAboveField: Text(
                          Res.string.newPassword,
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
                          color: darkMode
                              ? Res.colors.textColorDark
                              : Res.colors.textColor,
                        ),
                      ).paddingOnly(
                        bottom: 16,
                      ),

                      /// Confirm Password field
                      ReactiveTextField(
                        formControlName:
                            ForgotPasswordForm.confirmPasswordControl,
                        hint: Res.string.reEnterPassword,
                        keyboardType: TextInputType.visiblePassword,
                        inputAction: TextInputAction.go,
                        validationMessages: {
                          forms.ValidationMessage.required: (_) =>
                              Res.string.thisFieldIsRequired,
                          forms.ValidationMessage.mustMatch: (_) =>
                              Res.string.newConfirmPasswordNotMatched,
                          forms.ValidationMessage.minLength: (_) =>
                              Res.string.passwordLengthError,
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
                          color: darkMode
                              ? Res.colors.textColorDark
                              : Res.colors.textColor,
                        ),
                      ).paddingOnly(
                        bottom: 16,
                      ),

                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: cubit.submit,
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0.0),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                        ),
                        child: state.loading
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
                                Res.string.submit,
                                style: TextStyle(
                                  color: Res.colors.whiteColor,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ).paddingSymmetric(
                                vertical: 12,
                                horizontal: 32,
                              ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
