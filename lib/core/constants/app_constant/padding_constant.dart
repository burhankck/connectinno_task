import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaddingConstant {
  static PaddingConstant? _instance;
  static PaddingConstant get instance {
    if (_instance == null) {
      _instance = PaddingConstant._init();
    }
    return _instance!;
  }

  PaddingConstant._init();

  final pagePadding = EdgeInsets.symmetric(horizontal: 12, vertical: 12);
  final pagePadding10 = EdgeInsets.symmetric(horizontal: 10, vertical: 10);

 

  

  final horizontalPadding20w = EdgeInsets.symmetric(horizontal: 20.w);

  
  final onlyBottomPadding10 = const EdgeInsets.only(bottom: 10);
  final onlyBottomPadding50 = const EdgeInsets.only(bottom: 50);
  final onlyBottomPadding80 = const EdgeInsets.only(bottom: 80);

  final allPadding8 = const EdgeInsets.all(8.0);

  final allPadding4 = const EdgeInsets.all(6.0);
  final allPadding2 = const EdgeInsets.all(2.0);
  final allPadding16 = const EdgeInsets.all(16.0);

  final onlyRight8 = const EdgeInsets.only(right: 8.0);
  final onlyRight16 = const EdgeInsets.only(right: 16.0);
  final onlyRight24 = const EdgeInsets.only(right: 24.0);
  final onlyRight32 = const EdgeInsets.only(right: 32.0);
  final onlyLeft8 = const EdgeInsets.only(left: 8.0);
  final onlyLeft20 = EdgeInsets.only(left: 30.w);
  final onlyLeft24 = EdgeInsets.only(left: 36.w);

 
  final onlyTop30 = const EdgeInsets.only(top: 30.0);
  final onlyBottom20 = const EdgeInsets.only(bottom: 20.0);
  final onlyTop10 = const EdgeInsets.only(top: 10.0);


  final onlyBottom16 = const EdgeInsets.only(bottom: 12, right: 4);
  final horizontalPadding16 = const EdgeInsets.symmetric(horizontal: 16);
  final symmetric12And16 = const EdgeInsets.symmetric(
    vertical: 12,
    horizontal: 16,
  );

  final allPagePadding12 = const EdgeInsets.all(12);
  final symetrich16v12 = const EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 12,
  );

  final allPadding20 = const EdgeInsets.symmetric(vertical: 20, horizontal: 20);

}
