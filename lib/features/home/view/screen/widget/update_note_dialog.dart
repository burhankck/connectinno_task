import 'package:connectinno_task/core/constants/app_constant/color_constant.dart';
import 'package:connectinno_task/core/constants/app_constant/sizedbox_constant.dart';
import 'package:connectinno_task/core/constants/app_constant/text_style_constant.dart';
import 'package:connectinno_task/core/constants/app_widget/app_text_field.dart';
import 'package:connectinno_task/features/home/model/notes_list_model.dart';
import 'package:connectinno_task/features/home/view_model/home_cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class UpdateNoteDialog extends StatefulWidget {
  final NotesListModel note;
  final int index;

  const UpdateNoteDialog({super.key, required this.note, required this.index});

  @override
  State<UpdateNoteDialog> createState() => _UpdateNoteDialogState();
}

class _UpdateNoteDialogState extends State<UpdateNoteDialog>
    with _PageProperties {
  @override
  void initState() {
    super.initState();
    homeCubit = context.read<HomeCubit>();

    note = widget.note;
    updateTitleController.text = note.title;
    updateContentController.text = note.content;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorConstant.instance.grey800,
      title: Center(
        child: Text(
          "Notu Güncelle",
          style: TextStyleConstant.headText.copyWith(
            color: ColorConstant.instance.blackColor,
          ),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppTextField(
            cursorColor: ColorConstant.instance.blueColor,
            controller: updateTitleController,
            decoration: InputDecoration(
              labelText: "Başlık",
              labelStyle: TextStyleConstant.bodyXLWhiteColor.copyWith(
                color: ColorConstant.instance.blackColor,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: ColorConstant.instance.blueColor),
              ),
            ),
          ),

          SizedBoxConstant.instance.sized12h,
          AppTextField(
            controller: updateContentController,
            maxLines: 2,
            cursorColor: ColorConstant.instance.blueColor,
            decoration: InputDecoration(
              labelText: "Not",
              labelStyle: TextStyleConstant.bodyXLWhiteColor.copyWith(
                color: ColorConstant.instance.blackColor,
              ),

              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: ColorConstant.instance.blueColor),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: Text(
            "İptal",
            style: TextStyleConstant.bodyLargeWhiteColor.copyWith(
              color: ColorConstant.instance.blackColor,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            homeCubit.updateNote(
              index: widget.index,
              newTitle: updateTitleController.text,
              newContent: updateContentController.text,
            );
            context.pop();
          },
          child: Text(
            "Güncelle",
            style: TextStyleConstant.bodyLargeWhiteColor.copyWith(
              color: ColorConstant.instance.blackColor,
            ),
          ),
        ),
      ],
    );
  }
}

mixin _PageProperties {
  late HomeCubit homeCubit;
  late NotesListModel note;
  final TextEditingController updateTitleController = TextEditingController();
  final TextEditingController updateContentController = TextEditingController();
}
