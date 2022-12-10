import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart' as forms;

import '../../../../resources/resources.dart';
import '../../../app.dart';

class ChildModeScreen extends StatelessWidget {
  const ChildModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChildModeCubit(context),
      child: Scaffold(
        body: BlocConsumer<ChildModeCubit, ChildModeState>(
          listenWhen: (prev, curr) =>
              prev.apiResponseStatus != curr.apiResponseStatus,
          listener: (context, state) {
            switch (state.apiResponseStatus) {
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
            var cubit = context.read<ChildModeCubit>();
            return SafeArea(
              child: GestureDetector(
                onTap: cubit.childModeForm.unfocus,
                child: forms.ReactiveForm(
                  formGroup: cubit.childModeForm,
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
                          Center(
                            child: Text(
                              Res.string.enterCodeHere,
                              style: const TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),

                          // Code Field
                          ReactiveTextField(
                            formControlName: ChildModeForms.codeControl,
                            textAlign: TextAlign.center,
                            hint: Res.string.enterCodeHere,
                            keyboardType: TextInputType.text,
                            inputAction: TextInputAction.go,
                            validationMessages: {
                              forms.ValidationMessage.required: (_) =>
                                  Res.string.thisFieldIsRequired,
                            },
                          ).paddingOnly(
                            bottom: 16,
                          ),
                          const SizedBox(height: 32),
                          SizedBox(
                            width: double.maxFinite,
                            child: ElevatedButton(
                              onPressed: cubit.submit,
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0.0),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                ),
                              ),
                              child: Text(
                                Res.string.submit,
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
}
