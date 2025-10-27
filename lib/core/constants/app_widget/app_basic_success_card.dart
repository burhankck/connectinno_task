import 'package:connectinno_task/core/constants/app_constant/color_constant.dart';
import 'package:connectinno_task/core/constants/app_constant/image_constant.dart';
import 'package:connectinno_task/core/constants/app_constant/padding_constant.dart';
import 'package:connectinno_task/core/constants/app_constant/sizedbox_constant.dart';
import 'package:connectinno_task/core/constants/app_constant/text_style_constant.dart';
import 'package:connectinno_task/extensions/app_extensions.dart';
import 'package:flutter/material.dart';

class BasicSuccessCard extends StatelessWidget {
  final String firstDescription;
  final String secondDescription;
  final VoidCallback? onPressed;

  const BasicSuccessCard({
    super.key,
    required this.firstDescription,
    required this.secondDescription,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: context.getHeight * 0.3,
        width: context.getWidth * 0.8,
        child: Card(
          color: ColorConstant.instance.whiteColor,
          elevation: 0,
          borderOnForeground: true,
          child: Padding(
            padding: PaddingConstant.instance.allPadding20,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 24.0,
                    backgroundColor: ColorConstant.instance.grey800,
                    child: Image.asset(
                      ImageConstant.instance.checkImage, 
                      color: ColorConstant.instance.greenColor, 
                    ),
                  ),
                  SizedBoxConstant.instance.sized6h,

                  Center(
                    child: Text(
                      firstDescription,
                      textAlign: TextAlign.center,
                      style: TextStyleConstant.headText.copyWith(
                        color: ColorConstant.instance.blackColor,
                      ),
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  SizedBoxConstant.instance.sized12h,

                  Center(
                    child: Text(
                      secondDescription,
                      textAlign: TextAlign.center,
                      style: TextStyleConstant.bodyMediumWhite.copyWith(
                        color: ColorConstant.instance.blackColor,
                      ),
                    ),
                  ),
                  SizedBoxConstant.instance.sized12h,

                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstant.instance.primaryColor,
                      ),
                      onPressed: onPressed,
                      child: Text(
                        "Tamam",
                        style: TextStyle(
                          color: ColorConstant.instance.whiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}