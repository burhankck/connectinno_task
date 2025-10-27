import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:connectinno_task/core/constants/app_widget/app_basic_error_card.dart';
import 'package:connectinno_task/core/constants/app_widget/app_button.dart';
import 'package:connectinno_task/core/constants/app_widget/app_loading.dart';
import 'package:connectinno_task/core/constants/app_widget/app_textfield.dart';
import 'package:connectinno_task/core/constants/app_constant/color_constant.dart';
import 'package:connectinno_task/core/constants/app_constant/icon_constant.dart';
import 'package:connectinno_task/core/constants/app_constant/image_constant.dart';
import 'package:connectinno_task/core/constants/app_constant/padding_constant.dart';
import 'package:connectinno_task/core/constants/app_constant/sizedbox_constant.dart';
import 'package:connectinno_task/core/constants/app_constant/text_style_constant.dart';
import 'package:connectinno_task/core/router_navigation/app_router_name.dart';
import 'package:connectinno_task/extensions/app_extensions.dart';
import 'package:connectinno_task/features/auth/view_model/auth_cubit/auth_cubit.dart';

class AuthView extends StatefulWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> with _Pageproperties {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _initCubits();
    authCubit.clearControllers();
    super.initState();
  }

  void _initCubits() {
    authCubit = context.read<AuthCubit>();
  }

  @override
  Widget build(BuildContext context) {
   

    return Scaffold(
      backgroundColor: ColorConstant.instance.grey800,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (_) => Dialog(
                backgroundColor: Colors.transparent,
                insetPadding: EdgeInsets.zero,
                child: BasicErrorCard(
                  firstDescription: state.title,
                  secondDescription: state.description,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            );
          } else if (state is AuthDisplay) {
            context.go(AppRouters.root);
          }
        },
        builder: (context, state) {
          // if (state is AuthLoading || state is AuthDisplay) {
          //   return const AppLoading();
          // }

          return SingleChildScrollView(
            child: Padding(
              padding: PaddingConstant.instance.pagePadding,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Image.asset(
                      ImageConstant.instance.stickNoteImage,
                      height: context.getHeight * 0.35,
                      width: context.getWidth * 0.40,
                      color: ColorConstant.instance.whiteColor,
                    ),
                    SizedBoxConstant.instance.sized24h,
                    AppTextFormField(
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return "E-mail gerekli.";
                        }
                        return null;
                      },
                      controller: authCubit.emailController,
                      hintText: 'E-mail',
                      prefixIcon: IconConstant.mailIcon,
                    ),
                    SizedBoxConstant.instance.sized12h,
                    AppTextFormField(
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return "Şifre gerekli.";
                        }
                        return null;
                      },
                      controller: authCubit.passwordController,
                      hintText: 'Şifre',
                      prefixIcon: IconConstant.lockIcon,
                      obsureText: authCubit.obscurePassword,
                      suffix: IconButton(
                        icon: authCubit.obscurePassword
                            ? IconConstant.visibilityOffIcon
                            : IconConstant.visibilityIcon,
                        onPressed: () => authCubit.togglePasswordVisibility(),
                      ),
                    ),
                    SizedBoxConstant.instance.sized16h,
                    CustomElevatedButton(
                      onPress: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          authCubit.getAuth();
                        }
                      },
                      text: "Giriş Yap",
                      textStyle: TextStyleConstant.bodyLargew700.copyWith(
                        color: ColorConstant.instance.whiteColor,
                      ),
                    ),
                    SizedBoxConstant.instance.sized16h,
                    Center(
                      child: GestureDetector(
                        onTap: () => context.push(AppRouters.register),
                        child: RichText(
                          text: TextSpan(
                            text: "Hesabınız yok mu? ",
                            style: TextStyleConstant.bodyMediumWhite.copyWith(
                              color: ColorConstant.instance.whiteColor,
                            ),
                            children: [
                              TextSpan(
                                text: "Kayıt Ol",
                                style: TextStyleConstant.bodyMediumWhite
                                    .copyWith(
                                      color: ColorConstant.instance.blueColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

mixin _Pageproperties {
  AuthCubit authCubit = AuthCubit();
}
