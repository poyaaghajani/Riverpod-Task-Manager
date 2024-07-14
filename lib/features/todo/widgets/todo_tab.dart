import 'package:flutter/material.dart';
import 'package:task_manager/core/constants/constants.dart';
import 'package:task_manager/core/widgets/reusable_style.dart';
import 'package:task_manager/core/widgets/reusable_text.dart';

class ToDoTab extends StatelessWidget {
  const ToDoTab({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: SizedBox(
        width: AppConst.appWidth * 0.5,
        child: Center(
          child: ReusableText(
            text: text,
            style: reusableStyle(
              16,
              AppConst.dark,
              FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
