import 'package:connectinno_task/core/constants/app_constant/border_radius_constant.dart';
import 'package:connectinno_task/core/constants/app_constant/color_constant.dart';
import 'package:connectinno_task/core/constants/app_constant/padding_constant.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final void Function()? onPress;
  final String text;
  final Color? color;
  final TextStyle? textStyle;

  const CustomElevatedButton({
    Key? key,
    required this.onPress,
    required this.text,
    this.color,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PaddingConstant.instance.horizontalPadding20w,
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? ColorConstant.instance.blackColor,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusConstant.instance.radius8,
            side: BorderSide.none,
          ),

          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
        ),
        child: Center(
          child: Text(text, textAlign: TextAlign.center, style: textStyle),
        ),
      ),
    );
  }
}
