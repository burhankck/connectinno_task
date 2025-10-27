import 'package:connectinno_task/core/constants/app_constant/color_constant.dart';
import 'package:connectinno_task/core/constants/app_constant/icon_constant.dart';
import 'package:connectinno_task/core/constants/app_widget/app_loading.dart';
import 'package:connectinno_task/core/constants/app_constant/image_constant.dart';
import 'package:connectinno_task/core/constants/app_constant/padding_constant.dart';
import 'package:connectinno_task/core/constants/app_constant/sizedbox_constant.dart';
import 'package:connectinno_task/core/constants/app_constant/text_style_constant.dart';
import 'package:connectinno_task/core/router_navigation/app_router_name.dart';
import 'package:connectinno_task/extensions/app_extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    _checkAuth();

    super.initState();
  }

  

  Future<void> _checkAuth() async {
    await Future.delayed(const Duration(seconds: 1));

    final user = FirebaseAuth.instance.currentUser;

    if (user != null && user.email != null) {
      context.go(AppRouters.root);
    } else {
      context.go(AppRouters.auth);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.instance.grey800,
      body: Padding(
        padding: PaddingConstant.instance.pagePadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              ImageConstant.instance.stickNoteImage,
              height: context.getHeight * 0.35,
              width: context.getWidth * 0.40,

              color: ColorConstant.instance.whiteColor,
            ),
            SizedBoxConstant.instance.sized12h,

            Text('Connectinno Notes', style: TextStyleConstant.headText),
            SizedBoxConstant.instance.sized50h,

            AppLoading(),
          ],
        ),
      ),
    );
  }
}
