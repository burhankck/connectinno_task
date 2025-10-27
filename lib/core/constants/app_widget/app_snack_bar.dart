import 'package:connectinno_task/core/constants/app_constant/text_style_constant.dart';
import 'package:flutter/material.dart';
import 'package:connectinno_task/core/constants/app_constant/color_constant.dart';

class CustomSnackbar {
  static Future<void> show(
    BuildContext context, {
    required String message,
    bool isSuccess = true,
    int durationSeconds = 3,
    String? actionLabel,
    VoidCallback? onActionPressed,
  }) async {
    final snackBar = SnackBar(
      content: Text(message, style: TextStyleConstant.bodyLargeWhiteColor),
      backgroundColor: isSuccess
          ? ColorConstant.instance.greenColor
          : ColorConstant.instance.red,
      duration: Duration(seconds: durationSeconds),
      behavior: SnackBarBehavior.floating,
      action: actionLabel != null
          ? SnackBarAction(
              label: actionLabel,
              textColor: ColorConstant.instance.whiteColor,
              onPressed: onActionPressed ?? () {},
            )
          : null,
    );

    final controller = ScaffoldMessenger.of(context).showSnackBar(snackBar);
    await controller.closed;
  }
}
