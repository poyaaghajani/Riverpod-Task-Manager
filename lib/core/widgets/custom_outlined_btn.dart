import 'package:flutter/material.dart';
import 'package:task_manager/core/widgets/reusable_style.dart';
import 'package:task_manager/core/widgets/reusable_text.dart';

class CustomOutlinedBtn extends StatelessWidget {
  const CustomOutlinedBtn({
    super.key,
    required this.onTap,
    required this.height,
    required this.width,
    this.bgColor,
    required this.color,
    required this.text,
  });

  final void Function()? onTap;
  final double width;
  final double height;
  final Color? bgColor;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1, color: color),
        ),
        child: Center(
          child: ReusableText(
            text: text,
            style: reusableStyle(18, color, FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
