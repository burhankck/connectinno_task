import 'package:connectinno_task/core/constants/app_constant/border_radius_constant.dart';
import 'package:connectinno_task/core/constants/app_constant/color_constant.dart';
import 'package:connectinno_task/core/constants/app_constant/text_style_constant.dart';
import 'package:connectinno_task/core/constants/app_widget/app_button.dart';
import 'package:connectinno_task/core/constants/app_widget/app_loading.dart';
import 'package:connectinno_task/core/constants/app_widget/app_snack_bar.dart';
import 'package:connectinno_task/core/router_navigation/app_router_name.dart';
import 'package:connectinno_task/features/profil/view_model/profil_cubit/profil_cubit.dart';
import 'package:flutter/material.dart';
import 'package:connectinno_task/core/constants/app_constant/padding_constant.dart';
import 'package:connectinno_task/core/constants/app_constant/sizedbox_constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with _PageProperties {
  @override
  void initState() {
    super.initState();

    _initCubits();
    profileCubit.refreshProfile();
  }

  void _initCubits() {
    profileCubit = context.read<ProfileCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.instance.grey800,

      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileDisplay) {
            context.go(AppRouters.splash);
          } else if (state is ProfileError) {
            CustomSnackbar.show(
              context,
              message: state.description,
              isSuccess: false,
              durationSeconds: 3,
            );
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: AppLoading());
          } else if (state is ProfileLoaded) {
            return Padding(
              padding: PaddingConstant.instance.pagePadding,
              child: Column(
                children: [
                  SizedBoxConstant.instance.sized50h,

                  Padding(
                    padding: PaddingConstant.instance.onlyTop30,
                    child: Card(
                      color: ColorConstant.instance.primaryColor,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusConstant.instance.radius12,
                      ),
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: PaddingConstant.instance.allPadding16,
                        child: Column(
                          children: [
                            SizedBoxConstant.instance.sized50h,
                            Text(
                              'Profil Bilgileri',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBoxConstant.instance.sized20h,
                            Text(
                              "Merhaba! ${state.displayName.isNotEmpty ? state.displayName.toUpperCase() : "Kullanıcı"}",
                              style: TextStyleConstant.bodyLargeWhiteColor,
                            ),
                            SizedBoxConstant.instance.sized20h,
                            CustomElevatedButton(
                              onPress: () {
                                profileCubit.logOut();
                              },
                              text: "Çıkış Yap",
                              textStyle: TextStyleConstant.bodyLargew700
                                  .copyWith(
                                    color: ColorConstant.instance.whiteColor,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is ProfileError) {
            return Center(
              child: Text(
                state.description,
                style: TextStyleConstant.bodyLargeWhiteColor,
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

mixin _PageProperties {
  ProfileCubit profileCubit = ProfileCubit();
}
