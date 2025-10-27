import 'package:connectinno_task/core/constants/app_widget/app_basic_error_card.dart';
import 'package:connectinno_task/core/constants/app_widget/app_basic_success_card.dart';
import 'package:connectinno_task/core/constants/app_widget/app_button.dart';
import 'package:connectinno_task/core/constants/app_widget/app_loading.dart';
import 'package:connectinno_task/core/constants/app_widget/app_textfield.dart';
import 'package:connectinno_task/core/constants/app_constant/color_constant.dart';
import 'package:connectinno_task/core/constants/app_constant/icon_constant.dart';
import 'package:connectinno_task/core/constants/app_constant/image_constant.dart';
import 'package:connectinno_task/core/constants/app_constant/text_style_constant.dart';
import 'package:connectinno_task/core/router_navigation/app_router_name.dart';
import 'package:connectinno_task/extensions/app_extensions.dart';
import 'package:connectinno_task/features/register/view_model/register_cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:connectinno_task/core/constants/app_constant/padding_constant.dart';
import 'package:connectinno_task/core/constants/app_constant/sizedbox_constant.dart';
import 'package:go_router/go_router.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final registerCubit = context.read<RegisterCubit>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: ColorConstant.instance.transparent,
        leading: IconButton(
          icon: IconConstant.arrowBackIcon,
          onPressed: () {
            context.pop(context);
          },
        ),
      ),
      backgroundColor: ColorConstant.instance.grey800,
      body: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterError) {
            showDialog(
              context: context,
              barrierDismissible: true, // dışa tıklayınca da kapanabilir
              builder: (_) => Dialog(
                backgroundColor: Colors.transparent, // kartın dışı saydam
                insetPadding: EdgeInsets.zero,
                child: BasicErrorCard(
                  firstDescription: state.title,
                  secondDescription: state.description,
                  onPressed: () => context.pop(context),
                ),
              ),
            );
          } else if (state is RegisterDisplay) {
            showDialog(
              context: context,
              barrierDismissible: false, // Kullanıcı Tamam'a basmadan kapatamaz
              builder: (_) => Dialog(
                backgroundColor: Colors.transparent,
                insetPadding: EdgeInsets.zero,
                child: BasicSuccessCard(
                  firstDescription: "Kayıt Başarılı!",
                  secondDescription:
                      "Notlarınızı oluşturmaya başlayabilirsiniz.",
                  onPressed: () {
                    // 1. Diyaloğu kapat
                    Navigator.pop(context);
                    context.go(AppRouters.root);
                  },
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is RegisterLoading) {
            return const AppLoading();
          }
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
                          return "Adınız gerekli.";
                        }
                        return null;
                      },
                      controller: registerCubit.usernameController,
                      hintText: 'Adınız',
                      prefixIcon: IconConstant.personIcon,
                    ),
                    SizedBoxConstant.instance.sized12h,
                    AppTextFormField(
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return "E-mail gerekli.";
                        }
                        return null;
                      },
                      controller: registerCubit.emailController,
                      hintText: 'E-mail',
                      prefixIcon: IconConstant.mailIcon,
                    ),
                    SizedBoxConstant.instance.sized12h,
                    AppTextFormField(
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return "Şifre gerekli.";
                        }
                        if (p0.length < 6) {
                          return "Şifre en az 6 karakter olmalıdır.";
                        }
                        return null;
                      },
                      controller: registerCubit.passwordController,
                      hintText: 'Şifre',
                      prefixIcon: IconConstant.lockIcon,
                    ),
                    SizedBoxConstant.instance.sized16h,
                    CustomElevatedButton(
                      onPress: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          registerCubit.getSignUp();
                        }
                      },
                      text: "Kayıt Ol",
                      textStyle: TextStyleConstant.bodyLargew700.copyWith(
                        color: ColorConstant.instance.whiteColor,
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
