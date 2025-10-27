import 'package:connectinno_task/core/constants/app_constant/color_constant.dart';
import 'package:connectinno_task/core/constants/app_constant/text_style_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  final String? hintText, labelText;
  final Widget? prefixIcon, suffixIcon;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final bool? readOnly;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final String? errorText;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final VoidCallback? onTap;
  final void Function(String)? onFieldSubmitted;
  final InputDecoration? decoration;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final TextStyle? labelStyle;
  final TextStyle? suffixStyle;
  final Color? cursorColor;
  final String? suffixText;
  const AppTextField({
    Key? key,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.keyboardType,
    required this.controller,
    this.readOnly = false,
    this.obscureText,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.errorText,
    this.onTap,
    this.focusNode,
    this.onFieldSubmitted,
    this.textInputAction,
    this.decoration,
    this.floatingLabelBehavior,
    this.maxLines,
    this.minLines,
    this.maxLength,
    this.labelStyle,
    this.suffixText,
    this.suffixStyle,
    this.cursorColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      focusNode: focusNode,
      autofocus: false,
      onFieldSubmitted: onFieldSubmitted,
      obscureText: obscureText ?? false,
      onChanged: onChanged,
      textInputAction: textInputAction ?? TextInputAction.next,
      controller: controller,
      maxLines: maxLines ?? 1,
      minLines: minLines ?? 1,
      onTap: onTap,
      style: TextStyleConstant.bodyMediumSize,
      keyboardType: keyboardType,
      readOnly: readOnly ?? false,
      cursorColor: cursorColor ?? ColorConstant.instance.whiteColor,
      inputFormatters: [
        if (maxLength != null) LengthLimitingTextInputFormatter(maxLength),
      ],
      decoration:
          decoration ??
          InputDecoration(
            hintStyle: TextStyleConstant.bodyMediumSize.copyWith(
              color: ColorConstant.instance.grey800,
            ),
            floatingLabelBehavior: floatingLabelBehavior,
            iconColor: ColorConstant.instance.blueColor,
            hintText: hintText,
            labelText: labelText,
            errorText: errorText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            labelStyle: labelStyle,
            errorMaxLines: 5,
            suffixText: suffixText,
            suffixStyle: suffixStyle,
          ),
    );
  }
}
