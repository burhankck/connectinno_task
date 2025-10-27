import 'package:flutter/material.dart';



extension ScreenSizeExtension on BuildContext{
   double get getWidth => MediaQuery.of(this).size.width;
  double get getHeight => MediaQuery.of(this).size.height;
}


