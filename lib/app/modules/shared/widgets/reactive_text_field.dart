import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart' as r;

import '../../../../resources/resources.dart';
import '../../../app.dart';

class ReactiveTextField extends StatelessWidget {
  ReactiveTextField({
    Key? key,
    this.formControlName,
    this.labelWidget,
    this.floatingLabelBehavior = FloatingLabelBehavior.never,
    this.label,
    this.hint,
    this.height,
    this.focusNode,
    this.keyboardType,
    this.inputAction,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.prefixWidget,
    this.suffixTap,
    this.suffixWidget,
    this.validationMessages,
    this.fillColor,
    this.readOnly = false,
    this.obscureText = false,
    this.autofocus = false,
    this.isMultiline = false,
    this.disabledBorder = false,
    this.contentPadding,
    this.widgetAboveField,
    this.maxLength,
    this.showCounter = false,
    this.textAlign = TextAlign.left,
    this.textDirection = TextDirection.ltr,
    this.noBorder = false,
    this.onTap,
    this.darkMode = false,
    this.decoration,
    this.maxLines,
  })  : assert(formControlName != null),
        super(key: key);

  final String? formControlName;
  final Widget? labelWidget;
  final FloatingLabelBehavior floatingLabelBehavior;
  final String? label;
  final String? hint;
  final double? height;
  final bool obscureText;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final TextInputAction? inputAction;
  final TextCapitalization textCapitalization;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final Function()? suffixTap;
  final Map<String, String Function(Object)>? validationMessages;
  final Color? fillColor;
  final bool autofocus;
  final bool readOnly;
  final bool isMultiline;
  final bool disabledBorder;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? widgetAboveField;
  final int? maxLength;
  final bool showCounter;
  final TextAlign textAlign;
  final TextDirection textDirection;
  final bool noBorder;
  final Function(r.FormControl<Object?>)? onTap;
  final bool darkMode;
  final InputDecoration? decoration;
  final int? maxLines;

  final enabledBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: const BorderSide(
      style: BorderStyle.solid,
      color: Colors.black45,
    ),
  );

  final focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: BorderSide(
      style: BorderStyle.solid,
      color: Res.colors.materialColor,
    ),
  );

  final errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: BorderSide(
      style: BorderStyle.solid,
      color: Res.colors.redColor,
    ),
  );

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: height,
      child: r.ReactiveTextField(
        formControlName: formControlName,
        validationMessages:
            validationMessages ?? {'required': (c) => 'This field is required'},
        obscureText: obscureText,
        focusNode: focusNode,
        keyboardType: isMultiline ? TextInputType.multiline : keyboardType,
        textInputAction: inputAction,
        textCapitalization: textCapitalization,
        inputFormatters: inputFormatters,
        autofocus: autofocus,
        onTap: onTap,
        readOnly: readOnly,
        expands: isMultiline ? true : false,
        maxLines: maxLines ?? (isMultiline ? null : 1),
        textAlignVertical: isMultiline ? TextAlignVertical.top : null,
        cursorColor: Res.colors.materialColor,
        maxLength: maxLength,
        textAlign: textAlign,
        textDirection: textDirection,
        decoration: decoration ??
            InputDecoration(
              labelText: label,
              label: labelWidget,
              filled: true,
              fillColor: fillColor,
              floatingLabelBehavior: floatingLabelBehavior,
              labelStyle: textTheme.bodyText2,
              hintText: hint,
              hintStyle: textTheme.bodyText2?.copyWith(
                color: Res.colors.hintTextColor,
              ),
              counter: showCounter ? null : const SizedBox.shrink(),
              contentPadding: contentPadding ??
                  const EdgeInsets.only(
                    top: 20,
                    left: 16,
                    right: 16,
                    bottom: 0,
                  ),
              border: noBorder ? InputBorder.none : null,
              // border: noBorder
              //     ? InputBorder.none
              //     : UnderlineInputBorder(
              //         borderSide: BorderSide(
              //           color: darkMode ? Colors.white70 : Colors.black45,
              //           style: BorderStyle.solid,
              //           width: 4,
              //           strokeAlign: StrokeAlign.inside,
              //         ),
              //       ),
              // EdgeInsets.symmetric(
              //   horizontal: 16,
              //   vertical: isMultiline ? 16 : 0.0,
              // ),
              // border: !disabledBorder ? enabledBorder : InputBorder.none,
              // enabledBorder: !disabledBorder ? enabledBorder : InputBorder.none,
              // focusedBorder: !disabledBorder ? focusedBorder : InputBorder.none,
              // errorBorder: !disabledBorder ? errorBorder : InputBorder.none,
              // focusedErrorBorder: !disabledBorder ? errorBorder : InputBorder.none,
              errorStyle: TextStyle(
                color: Res.colors.chestnutRedColor,
              ),
              prefixIcon: prefixWidget,
              suffixIcon: suffixWidget,
            ),
      ),
    ).aboveWidget(
      widgetAboveField,
    );
  }
}
