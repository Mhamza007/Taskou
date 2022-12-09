import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart' as forms;

import '../../../../../resources/resources.dart';
import '../../../../app.dart';

class AddChildScreen extends StatelessWidget {
  const AddChildScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddChildCubit(context),
      child: BlocConsumer<AddChildCubit, AddChildState>(
        listenWhen: (prev, curr) =>
            prev.apiResponseStatus != curr.apiResponseStatus,
        listener: (context, state) {
          switch (state.apiResponseStatus) {
            case ApiResponseStatus.success:
              Helpers.successSnackBar(
                context: context,
                title: state.message,
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
          var cubit = context.read<AddChildCubit>();

          return Scaffold(
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
              title: Text(
                Res.string.tracking,
              ),
            ),
            body: forms.ReactiveForm(
              formGroup: cubit.addChildForm,
              child: ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(overscroll: false),
                child: ListView(
                  padding: const EdgeInsets.all(24.0),
                  children: [
                    /// Child Name field
                    ReactiveTextField(
                      formControlName: AddChildForm.childNameControl,
                      hint: Res.string.enterChildName,
                      keyboardType: TextInputType.name,
                      inputAction: TextInputAction.next,
                      validationMessages: {
                        forms.ValidationMessage.required: (_) =>
                            Res.string.thisFieldIsRequired,
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[a-z A-Z ]'))
                      ],
                      widgetAboveField: Text(
                        Res.string.childName,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: cubit.darkMode
                              ? Res.colors.textColorDark
                              : Res.colors.textColor,
                        ),
                      ).marginOnly(bottom: 8.0),
                      suffixWidget: SvgPicture.asset(
                        Res.drawable.user,
                        width: 24.0,
                        height: 24.0,
                        fit: BoxFit.scaleDown,
                        color: cubit.darkMode
                            ? Res.colors.textColorDark
                            : Res.colors.textColor,
                      ),
                      darkMode: cubit.darkMode,
                    ).paddingOnly(bottom: 16),

                    /// Relation field
                    ReactiveTextField(
                      formControlName: AddChildForm.relationControl,
                      hint: Res.string.enterRelation,
                      keyboardType: TextInputType.name,
                      inputAction: TextInputAction.next,
                      validationMessages: {
                        forms.ValidationMessage.required: (_) =>
                            Res.string.thisFieldIsRequired,
                      },
                      readOnly: true,
                      onTap: (p0) => cubit.chooseRelation(),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[a-z A-Z ]'))
                      ],
                      widgetAboveField: Text(
                        Res.string.relation,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: cubit.darkMode
                              ? Res.colors.textColorDark
                              : Res.colors.textColor,
                        ),
                      ).marginOnly(bottom: 8.0),
                      suffixWidget: SvgPicture.asset(
                        Res.drawable.user,
                        width: 24.0,
                        height: 24.0,
                        fit: BoxFit.scaleDown,
                        color: cubit.darkMode
                            ? Res.colors.textColorDark
                            : Res.colors.textColor,
                      ),
                      darkMode: cubit.darkMode,
                    ).paddingOnly(bottom: 32),

                    // Add button
                    ElevatedButton(
                      onPressed: cubit.addChild,
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0.0),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                      ),
                      child: state.loading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            ).paddingSymmetric(
                              vertical: 12,
                            )
                          : Text(
                              Res.string.add,
                              style: TextStyle(
                                color: Res.colors.whiteColor,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ).paddingSymmetric(
                              vertical: 16,
                              horizontal: 32,
                            ),
                    ).paddingOnly(bottom: 16),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
