import 'package:connectinno_task/core/constants/app_constant/border_radius_constant.dart';
import 'package:connectinno_task/core/constants/app_constant/color_constant.dart';
import 'package:connectinno_task/features/home/view/screen/home_screen.dart';
import 'package:connectinno_task/features/home/view_model/home_cubit/home_cubit.dart';
import 'package:connectinno_task/features/profil/view/screen/profil_screen.dart';
import 'package:connectinno_task/features/profil/view_model/profil_cubit/profil_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class RootView extends StatefulWidget {
  const RootView({super.key});

  @override
  State<RootView> createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _controller.addListener(() {
      if (_controller.index == 0) {
        context.read<HomeCubit>().refreshHome();
      } else if (_controller.index == 1) {
        context.read<ProfileCubit>().refreshProfile();
      }
    });
  }

  List<Widget> _buildScreens() {
    return [const HomeView(), const ProfileView()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: ("Anasayfa"),
        activeColorPrimary: ColorConstant.instance.whiteColor,
        inactiveColorPrimary: ColorConstant.instance.grey800,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: ("Profil"),
        activeColorPrimary: ColorConstant.instance.whiteColor,
        inactiveColorPrimary: ColorConstant.instance.grey800,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      backgroundColor: ColorConstant.instance.blackColor,
      decoration: NavBarDecoration(
        borderRadius: BorderRadiusConstant.instance.radius16,
        colorBehindNavBar: ColorConstant.instance.blackColor,
      ),
      navBarStyle: NavBarStyle.style1,
    );
  }
}
