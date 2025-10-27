import 'package:connectinno_task/core/constants/app_constant/color_constant.dart';
import 'package:connectinno_task/core/constants/app_constant/padding_constant.dart';
import 'package:connectinno_task/core/constants/app_constant/text_style_constant.dart';
import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.validator,
    this.keyboardType,
    this.maxLine,
    this.floatingLabelBehavior,
    this.prefixIcon,
    this.enable,
    this.onEditingComplete,
    this.onChanged,
    this.readOnly,
    this.hintStyle,
    this.suffix,
    this.onTap,
    this.obsureText = false,
  });

  final bool? enable;
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int? maxLine;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final Widget? prefixIcon;
  final void Function()? onEditingComplete;
  final void Function(String)? onChanged;
  final bool? readOnly;
  final TextStyle? hintStyle;
  final Widget? suffix;
  final bool obsureText;

  @override
  Widget build(BuildContext context) {
    final int? adjustedMaxLines = obsureText ? 1 : maxLine;

    final isMultiLine = (adjustedMaxLines ?? 1) > 1;

    Widget? adjustedPrefixIcon = prefixIcon;

    if (isMultiLine && prefixIcon != null) {
      adjustedPrefixIcon = Padding(
        padding: PaddingConstant.instance.onlyBottom20,
        child: prefixIcon,
      );
    }

    return Padding(
      padding: PaddingConstant.instance.horizontalPadding20w,
      child: TextFormField(
        obscureText: obsureText,
        onTap: onTap,
        readOnly: readOnly ?? false,
        enabled: enable,
        maxLines: adjustedMaxLines,
        onEditingComplete: onEditingComplete,
        onChanged: onChanged,
        onTapOutside: (event) {
          print('onTapOutside');
          FocusManager.instance.primaryFocus?.unfocus();
        },
        decoration: InputDecoration(
          errorStyle: TextStyleConstant.bodyMediumSize.copyWith(
            color: ColorConstant.instance.whiteColor,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 20,
          ),
          hintText: hintText,
          prefixIcon: adjustedPrefixIcon, 
          suffixIcon: suffix,
          labelText: labelText,
          floatingLabelBehavior: floatingLabelBehavior,
          labelStyle: TextStyleConstant.bodyTextSize.copyWith(
            color: ColorConstant.instance.white70Color,
            fontSize: 13,
          ),
          hintStyle:
              hintStyle ??
              Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: ColorConstant.instance.whiteColor,
              ),
          filled: true,
          fillColor: ColorConstant.instance.blackColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        validator: validator,
        keyboardType: keyboardType ?? TextInputType.multiline,
        controller: controller,
        style: TextStyle(color: ColorConstant.instance.whiteColor),
      ),
    );
  }
}
