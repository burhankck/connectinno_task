import 'package:connectinno_task/core/constants/app_widget/app_loading.dart';
import 'package:connectinno_task/core/constants/app_widget/app_snack_bar.dart';
import 'package:connectinno_task/core/constants/app_widget/app_textfield.dart';
import 'package:connectinno_task/core/constants/app_constant/border_radius_constant.dart';
import 'package:connectinno_task/core/constants/app_constant/color_constant.dart';
import 'package:connectinno_task/core/constants/app_constant/icon_constant.dart';
import 'package:connectinno_task/core/constants/app_constant/text_style_constant.dart';
import 'package:connectinno_task/features/home/view_model/home_cubit/home_cubit.dart';
import 'package:connectinno_task/features/notes_add/view_model/notes_add_cubit/notes_add_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectinno_task/core/constants/app_constant/padding_constant.dart';
import 'package:connectinno_task/core/constants/app_constant/sizedbox_constant.dart';
import 'package:go_router/go_router.dart';

class NotesAddView extends StatefulWidget {
  const NotesAddView({super.key});

  @override
  State<NotesAddView> createState() => _NotesAddViewState();
}

class _NotesAddViewState extends State<NotesAddView> with _PageProperties {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _initCubits();
    notesAddCubit.clear();
    notesAddCubit.initHive();
    notesAddCubit.checkInternet();
    super.initState();
  }

  void _initCubits() {
    notesAddCubit = context.read<NotesAddCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          BlocBuilder<NotesAddCubit, NotesAddState>(
            builder: (context, state) {
              bool isOffline = false;
              if (state is NotesAddInternetState) {
                isOffline = !state.hasInternet;
              }
              return isOffline
                  ? Padding(
                      padding: PaddingConstant.instance.onlyRight8,
                      child: IconConstant.wifiIcon,
                    )
                  : const SizedBox.shrink();
            },
          ),
        ],

        leading: IconButton(
          icon: IconConstant.arrowBackIcon,
          onPressed: () async {
            await context.read<NotesAddCubit>().saveNotesAdd();

            if (context.mounted) {
              Navigator.pop(context);

              context.read<HomeCubit>().refreshHome();
            }
          },
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,

        title: Text("NOT EKLE", style: TextStyleConstant.headText),
      ),

      backgroundColor: ColorConstant.instance.grey800,

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            notesAddCubit.saveNotesAdd();
          }
        },
        label: const Text(
          "Kaydet",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        icon: IconConstant.saveIcon,
        backgroundColor: ColorConstant.instance.greenColor,
        foregroundColor: ColorConstant.instance.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusConstant.instance.radius12,
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      body: BlocConsumer<NotesAddCubit, NotesAddState>(
        listener: (context, state) async {
          if (state is NotesAddDisplay) {
            await CustomSnackbar.show(
              context,
              message: state.message!,
              isSuccess: state.isSuccess,
            );

            if (state.isSuccess) {
              context.pop(true);
            }
          } else if (state is NotesAddError) {
            CustomSnackbar.show(
              context,
              message: "${state.title}: ${state.description}",
              isSuccess: false,
            );
          }
        },
        builder: (context, state) {
          if (state is NotesAddLoading) {
            return Center(child: const AppLoading());
          }

          return Padding(
            padding: PaddingConstant.instance.pagePadding,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBoxConstant.instance.sized50h,

                  Card(
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
                          AppTextFormField(
                            controller: notesAddCubit.headAddController,
                            hintText: "Başlık Ekle...",
                            maxLine: 1,
                            prefixIcon: IconConstant.addNotes,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Başlık alanı boş bırakılamaz';
                              }
                              return null;
                            },
                          ),

                          SizedBoxConstant.instance.sized12h,

                          AppTextFormField(
                            controller: notesAddCubit.noteAddController,
                            hintText: "Not Ekle...",
                            maxLine: 2,
                            prefixIcon: IconConstant.addNotes,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Not alanı boş bırakılamaz';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

mixin _PageProperties {
  NotesAddCubit notesAddCubit = NotesAddCubit();
}
