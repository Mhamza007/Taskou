import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reactive_forms/reactive_forms.dart' as r;

import '../../../../resources/resources.dart';
import '../../../app.dart';

class ReactivePhoneNumberField extends StatelessWidget {
  const ReactivePhoneNumberField({
    super.key,
    this.title,
    this.titleWidget,
    required this.countryCodeControlName,
    required this.phoneNumberControlName,
    this.hint,
    this.maxLength,
    this.pickCountry,
    this.flag,
    this.readOnly = false,
    this.showSuffix = true,
    this.darkMode = false,
  });

  final String? title;
  final Widget? titleWidget;
  final String countryCodeControlName;
  final String phoneNumberControlName;
  final String? hint;
  final int? maxLength;
  final Function(r.FormControl<Object?>)? pickCountry;
  final String? flag;
  final bool readOnly;
  final bool showSuffix;
  final bool darkMode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleWidget != null
            ? titleWidget!
            : title != null
                ? Text(
                    title!,
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  )
                : const SizedBox.shrink(),
        const SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.zero,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: ReactiveTextField(
                  formControlName: countryCodeControlName,
                  readOnly: true,
                  textAlign: TextAlign.end,
                  contentPadding: const EdgeInsets.only(
                    top: 20,
                  ),
                  validationMessages: {
                    r.ValidationMessage.required: (_) =>
                        Res.string.thisFieldIsRequired,
                  },
                  onTap: pickCountry,
                  prefixWidget: IconButton(
                    onPressed: null,
                    alignment: Alignment.bottomCenter,
                    icon: flag != null
                        ? Text(
                            flag!,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          )
                        : const Icon(Icons.flag),
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: ReactiveTextField(
                  formControlName: phoneNumberControlName,
                  readOnly: readOnly,
                  hint: hint, //Res.string.phoneNumber,
                  keyboardType: TextInputType.phone,
                  inputAction: TextInputAction.next,
                  maxLength: maxLength,
                  contentPadding: const EdgeInsets.only(
                    top: 20,
                    left: 0,
                    right: 16,
                  ),
                  validationMessages: {
                    r.ValidationMessage.required: (_) =>
                        Res.string.thisFieldIsRequired,
                    r.ValidationMessage.minLength: (_) =>
                        Res.string.invalidPhoneNumber,
                    r.ValidationMessage.maxLength: (_) =>
                        Res.string.invalidPhoneNumber,
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  suffixWidget: showSuffix
                      ? SvgPicture.asset(
                          Res.drawable.phone,
                          width: 24,
                          height: 24,
                          fit: BoxFit.scaleDown,
                          color: darkMode
                              ? Res.colors.textColorDark
                              : Res.colors.textColor,
                        )
                      : const SizedBox.shrink(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
