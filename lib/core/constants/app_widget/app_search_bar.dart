import 'package:connectinno_task/core/constants/app_constant/border_radius_constant.dart';
import 'package:connectinno_task/core/constants/app_constant/color_constant.dart';
import 'package:connectinno_task/core/constants/app_constant/padding_constant.dart';
import 'package:flutter/material.dart';

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({
    super.key,
    required this.onChanged,
    required this.searchTextController,
    this.hintText,
  });

  final Function(String)? onChanged;
  final TextEditingController? searchTextController;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: false,
      onChanged: (value) {
        onChanged?.call(value);
      },
      controller: searchTextController,
      style: TextStyle(color: ColorConstant.instance.whiteColor),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.black,
        prefixIcon: Icon(
          Icons.search,
          color: ColorConstant.instance.white70Color,
        ),
        hintText: hintText ?? 'Ara...',
        hintStyle: const TextStyle(color: Colors.white54),
        suffixIcon: InkWell(
          onTap: () {
            if (searchTextController != null) {
              searchTextController!.clear();
            }
            onChanged?.call("");
            FocusScope.of(context).unfocus();
          },
          child: Icon(Icons.close, color: ColorConstant.instance.white70Color),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadiusConstant.instance.radius12,
          borderSide: BorderSide.none,
        ),
        contentPadding: PaddingConstant.instance.symmetric12And16,
      ),
    );
  }
}
