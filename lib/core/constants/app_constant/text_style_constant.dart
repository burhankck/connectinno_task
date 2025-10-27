import 'package:flutter/widgets.dart';
import 'package:connectinno_task/core/constants/app_constant/color_constant.dart';

class TextStyleConstant {
  static TextStyleConstant? _instance;
  TextStyleConstant._internal();
  factory TextStyleConstant() => _instance ??= TextStyleConstant._internal();

  static final TextStyle headText = TextStyle(
    color: ColorConstant.instance.whiteColor,
    fontFamily: FontFamilyConstant.myNotesFont,
    fontSize: TextSizeConstant.headline1Size,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle bodyMediumWhite = TextStyle(
    fontSize: TextSizeConstant.bodyMediumSize,
    fontFamily: FontFamilyConstant.myNotesFont,
    color: ColorConstant.instance.whiteColor,
  );
  static const TextStyle bodyLargew700 = TextStyle(
    fontSize: TextSizeConstant.bodyLarge700Size,
    fontFamily: FontFamilyConstant.myNotesFont,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle bodyMediumWhiteColor = TextStyle(
    fontSize: TextSizeConstant.bodyMediumSize,
    fontFamily: FontFamilyConstant.myNotesFont,
    color: ColorConstant.instance.whiteColor,
  );

  static final TextStyle bodyLargeWhiteColor = TextStyle(
    fontSize: TextSizeConstant.headTextSize,
    fontFamily: FontFamilyConstant.myNotesFont,
    color: ColorConstant.instance.whiteColor,
  );
  static final TextStyle bodyXLWhiteColor = TextStyle(
    fontSize: TextSizeConstant.headLine2Size,
    fontFamily: FontFamilyConstant.myNotesFont,
    color: ColorConstant.instance.whiteColor,
  );

  static final TextStyle bodyLarge700white70 = TextStyle(
    fontSize: TextSizeConstant.bodyLarge700Size,
    fontFamily: FontFamilyConstant.myNotesFont,
    fontWeight: FontWeight.w700,
    color: ColorConstant.instance.white70Color,
  );
 

  static final TextStyle bodyMediumSize = TextStyle(
    fontFamily: FontFamilyConstant.myNotesFont,
    fontWeight: FontWeight.bold,
    fontSize: TextSizeConstant.bodyMediumSize,
    color: ColorConstant.instance.whiteColor,
  );

  static final TextStyle bodyTextSize = TextStyle(
    fontSize: TextSizeConstant.bodyTextSize,
    fontFamily: FontFamilyConstant.myNotesFont,
    color: ColorConstant.instance.white70Color,
  );
  
}

class FontFamilyConstant {
  static const String myNotesFont = 'myNotesFont';
}

class TextSizeConstant {
  static const double headline1Size = 32;
  static const double headTextSize = 18;
  static const double headLine2Size = 24;
  static const double bodyTextBoldSize = 12;
  static const double bodyTextSize = 12;
  static const double bodySmallSize = 10;
  static const double bodyXsmallSize = 4;
  static const double bodyMediumSize = 14;
  static const double bodyMediumLargeSize = 18;

  static const double bodyMediumBoldSize = 14;
  static const double bodyLarge700Size = 16;
  static const double bodyXLarge700Size = 20;
}
