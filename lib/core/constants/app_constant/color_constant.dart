import 'package:flutter/material.dart';

class ColorConstant {
  static final ColorConstant _instance = ColorConstant._init();
  static ColorConstant get instance => _instance;
  ColorConstant._init();

  //Tamamlayıcı Renkler
  final Color primaryColor = const Color(0xff003da5);
  

  

  final Color whiteColor = const Color(0xffffffff);
  
 
  final Color blackWithOpacity08 = Colors.black.withOpacity(0.8);
  final Color blackWithOpacity075 = Colors.black.withOpacity(0.75);
  final Color blackColor = Colors.black;
  final Color transparent = Colors.transparent;
  final Color greenColor = Colors.green;
  final Color white70Color = Colors.white70;
  final Color white24Color = Colors.white24;
  final Color blueColor = Colors.blue;
  final Color whiteColorOpacity03 = Colors.white.withOpacity(0.3);
  final Color yellowColor = Colors.yellow;

  final Color? grey800 = Colors.grey[800];

  final Color greyLight = Color(0xff96A4BCE5);

  final Color blueLight = Color(0xffF1F7FF);

  final Color orange = Color(0xffAD9200);

  final Color redInfoColor = Colors.red;
  
  final Color red = Color.fromARGB(255, 238, 86, 75);
}
