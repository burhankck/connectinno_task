import 'package:flutter/material.dart';

class BorderRadiusConstant {
  static final BorderRadiusConstant _instance = BorderRadiusConstant._init();
  static BorderRadiusConstant get instance => _instance;
  BorderRadiusConstant._init();

  final BorderRadius radius16 = BorderRadius.circular(16.0);
  final Radius borderRadius16 = const Radius.circular(16.0);
  
  final BorderRadius radius18 = BorderRadius.circular(18.0);
  final BorderRadius radius12 = BorderRadius.circular(12.0);
  final BorderRadius radius24 = BorderRadius.circular(24.0);
  final Radius borderRadius18 = const Radius.circular(18.0);
  final BorderRadius radius8 = BorderRadius.circular(8.0);
  final Radius borderRadius8 = const Radius.circular(8.0);
  
  final BorderRadius radius20 = BorderRadius.circular(20.0);
  
}
