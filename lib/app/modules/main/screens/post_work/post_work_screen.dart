import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart' as forms;

import '../../../../../resources/resources.dart';
import '../../../../app.dart';

class PostWorkScreen extends StatelessWidget {
  const PostWorkScreen({
    super.key,
    required this.data,
  });

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    final darkMode = Res.appTheme.getThemeMode() == ThemeMode.dark;

    InputBorder inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
    );

    return BlocProvider(
      create: (context) => PostWorkCubit(
        context,
        categoryData: data,
      ),
      child: BlocConsumer<PostWorkCubit, PostWorkState>(
        listenWhen: (prev, curr) =>
            prev.apiResponseStatus != curr.apiResponseStatus,
        listener: (context, state) {
          switch (state.apiResponseStatus) {
            case ApiResponseStatus.success:
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return AlertDialog(
                    title: Text(Res.string.appTitle),
                    content: Text(state.message),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text(Res.string.ok),
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
          var cubit = context.read<PostWorkCubit>();

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
                Res.string.postWork,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
              centerTitle: true,
            ),
            body: forms.ReactiveForm(
              formGroup: cubit.postWorkForm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    Res.string.advertisingCommunaction,
                  ),
                  const SizedBox(height: 32.0),
                  ReactiveTextField(
                    formControlName: PostWorkForms.address,
                    readOnly: true,
                    onTap: (control) {
                      cubit.getAddress();
                    },
                    decoration: InputDecoration(
                      hintText: Res.string.enterAddress,
                      border: inputBorder,
                      enabledBorder: inputBorder,
                    ),
                    validationMessages: {
                      forms.ValidationMessage.required: (_) =>
                          Res.string.thisFieldIsRequired,
                    },
                  ),
                  const SizedBox(height: 16.0),
                  ReactiveTextField(
                    formControlName: PostWorkForms.message,
                    decoration: InputDecoration(
                      hintText: Res.string.enterYourMessage,
                      border: inputBorder,
                      enabledBorder: inputBorder,
                    ),
                    maxLines: 6,
                    validationMessages: {
                      forms.ValidationMessage.required: (_) =>
                          Res.string.thisFieldIsRequired,
                    },
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.maxFinite,
                    height: 48.0,
                    child: ElevatedButton(
                      onPressed: cubit.postWork,
                      child: state.loading
                          ? Center(
                              child: CircularProgressIndicator(
                                color: Res.colors.whiteColor,
                              ),
                            )
                          : Text(
                              Res.string.bookServiceman,
                            ),
                    ),
                  ),
                ],
              ).paddingSymmetric(
                horizontal: 24.0,
                vertical: 28.0,
              ),
            ),
          ).onTap(() => Helpers.unFocus());
        },
      ),
    );
  }
}
