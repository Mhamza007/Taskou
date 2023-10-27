import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../../resources/resources.dart';
import '../../../app.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({
    super.key,
    this.data,
  });

  final Map? data;

  @override
  Widget build(BuildContext context) {
    var darkMode = Res.appTheme.getThemeMode() == ThemeMode.dark;

    return BlocProvider(
      create: (context) => OtpCubit(
        context,
        data: data,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<OtpCubit, OtpState>(
          listenWhen: (prev, curr) => prev.status != curr.status,
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
            var otpCubit = context.read<OtpCubit>();
            return GestureDetector(
              onTap: Helpers.unFocus,
              child: AbsorbPointer(
                absorbing: state.status == VerifyStatus.loading,
                child: SafeArea(
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      SvgPicture.asset(
                        darkMode
                            ? Res.drawable.appLogoDark
                            : Res.drawable.appLogo,
                      ).paddingSymmetric(horizontal: 60),
                      const SizedBox(height: 60.0),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 52),
                        padding: const EdgeInsets.all(16.0),
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Res.colors.materialColor,
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
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
                                    controller: otpCubit.pinController,
                                    length: 4,
                                    closeKeyboardWhenCompleted: true,
                                    textInputAction: TextInputAction.done,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    onChanged: otpCubit.onTextChanged,
                                    defaultPinTheme: PinTheme(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: darkMode
                                                ? Colors.white
                                                : Colors.black,
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
                            Text(
                              'Text to ${state.phoneNumber ?? ''} should arrive in 00:${otpCubit.getSeconds(state.seconds)} seconds',
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.maxFinite,
                              child: ElevatedButton(
                                // onPressed: state.buttonEnabled
                                //     ? otpCubit.verifyOtp
                                //     : null,
                                onPressed: otpCubit.verifyOtp,
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
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: state.timeUp ? otpCubit.resendOtp : null,
                        child: Text(
                          Res.string.resend,
                          style: TextStyle(
                            color: state.timeUp
                                ? Res.colors.materialColor
                                : Res.colors.textGreyColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            decoration: TextDecoration.underline,
                            decorationThickness: 2,
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
