import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/constants/constants.dart';
import 'package:task_manager/core/widgets/reusable_style.dart';

class CustomTextFiled extends StatelessWidget {
  const CustomTextFiled({
    super.key,
    this.keyboardType,
    required this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.hintStyle,
    required this.controller,
    this.onChanged,
    this.textInputAction,
  });

  final TextInputType? keyboardType;
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextStyle? hintStyle;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppConst.appWidth * 0.9,
      height: 60.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConst.radius),
        color: AppConst.light,
      ),
      child: TextFormField(
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        onChanged: onChanged,
        controller: controller,
        style: reusableStyle(18, AppConst.dark, FontWeight.w700),
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          suffixIconColor: AppConst.dark,
          prefixIconColor: AppConst.dark,
          hintStyle:
              hintStyle ?? reusableStyle(16, AppConst.dark, FontWeight.bold),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConst.radius),
            borderSide: const BorderSide(color: AppConst.red, width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConst.radius),
            borderSide: const BorderSide(color: Colors.transparent, width: 0.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConst.radius),
            borderSide: const BorderSide(color: AppConst.dark, width: 0.5),
          ),
        ),
      ),
    );
  }
}
