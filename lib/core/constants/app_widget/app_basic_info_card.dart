
import 'package:connectinno_task/core/constants/app_constant/color_constant.dart';
import 'package:connectinno_task/core/constants/app_constant/sizedbox_constant.dart';
import 'package:connectinno_task/core/constants/app_constant/text_style_constant.dart';
import 'package:flutter/material.dart';

class BasicInfoWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final double imageHeight;
  final double imageWidth;
  final Color? imageColor;
  final Color? titleColor;
  final Color? descriptionColor;

  const BasicInfoWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    this.imageHeight = 60,
    this.imageWidth = 60,
    this.imageColor,
    this.titleColor,
    this.descriptionColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              color: imageColor ?? ColorConstant.instance.whiteColor,
              height: imageHeight,
              width: imageWidth,
            ),
              SizedBoxConstant.instance.sized8h,
            Text(
              title,
              style: TextStyle(
                color: titleColor ?? ColorConstant.instance.whiteColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: FontFamilyConstant.myNotesFont,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBoxConstant.instance.sized6h,
            Text(
              description,
              style: TextStyle(
                color: descriptionColor ?? ColorConstant.instance.whiteColor,
                fontSize: 14,
                fontFamily: FontFamilyConstant.myNotesFont,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
