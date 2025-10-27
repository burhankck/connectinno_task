import 'package:connectinno_task/core/constants/app_constant/color_constant.dart';
import 'package:flutter/material.dart';

class AppLoading extends StatelessWidget {
  final Color? color;
  const AppLoading({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: 3,
        color: color ?? ColorConstant.instance.whiteColor,
      ),
    );
  }
}
