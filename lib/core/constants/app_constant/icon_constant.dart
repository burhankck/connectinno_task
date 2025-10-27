import 'package:connectinno_task/core/constants/app_constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconConstant {
  static Icon stickNoteIcon = Icon(
    Icons.sticky_note_2_outlined,
    size: 80.w,
    color: ColorConstant.instance.whiteColor,
  );

  static Icon mailIcon = Icon(
    Icons.mail,

    color: ColorConstant.instance.white70Color,
  );
  static Icon personIcon = Icon(
    Icons.person,

    color: ColorConstant.instance.white70Color,
  );
  static Icon arrowBackIcon = Icon(
    Icons.arrow_back,

    color: ColorConstant.instance.white70Color,
  );

  static Icon addIcon = Icon(
    Icons.add,

    color: ColorConstant.instance.whiteColor,
  );

   static Icon pinIcon = Icon(
    Icons.push_pin,
size: 26,
  );
   static Icon deleteIcon = Icon(
    Icons.delete,
size: 26,
color: ColorConstant.instance.red,
  );


  static Icon addNotes = Icon(
    Icons.note_add,

    color: ColorConstant.instance.whiteColor,
  );

  static Icon wifiIcon = Icon(
    Icons.wifi_off_rounded,

    color: ColorConstant.instance.red,
  );
  static Icon saveIcon = Icon(
    Icons.save,
    color: ColorConstant.instance.whiteColor,
  );

  static Icon lockIcon = Icon(
    Icons.lock,

    color: ColorConstant.instance.white70Color,
  );
  static Icon visibilityOffIcon = Icon(
    Icons.visibility_off,

    color: ColorConstant.instance.white70Color,
  );
  static Icon visibilityIcon = Icon(
    Icons.visibility,

    color: ColorConstant.instance.white70Color,
  );
}
