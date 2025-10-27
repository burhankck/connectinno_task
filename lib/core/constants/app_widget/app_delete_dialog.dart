import 'package:connectinno_task/core/constants/app_constant/color_constant.dart';
import 'package:connectinno_task/core/constants/app_constant/padding_constant.dart';
import 'package:connectinno_task/core/constants/app_constant/text_style_constant.dart';
import 'package:flutter/material.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final String noteTitle;

  const DeleteConfirmationDialog({
    Key? key,
    required this.onConfirm,
    required this.noteTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorConstant.instance.grey800,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

      title: Text(
        "Notu Sil: $noteTitle",
        style: TextStyleConstant.bodyMediumWhite,
      ),

      content: Text(
        "Bu notu silmek istediğinizden emin misiniz? Bu işlem geri alınabilir.",
        style: TextStyleConstant.bodyMediumSize,
      ),

      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorConstant.instance.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: PaddingConstant.instance.horizontalPadding16,
          ),
          child: Text(
            "Hayır",
            style: TextStyleConstant.bodyLarge700white70.copyWith(
              color: ColorConstant.instance.whiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(true);
            onConfirm();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorConstant.instance.greenColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: PaddingConstant.instance.horizontalPadding16,
          ),
          child: Text(
            "Evet",
            style: TextStyleConstant.bodyLarge700white70.copyWith(
              color: ColorConstant.instance.whiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
