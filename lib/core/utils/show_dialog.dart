import 'package:flutter/material.dart';
import 'package:task_manager/core/constants/constants.dart';
import 'package:task_manager/core/widgets/reusable_style.dart';
import 'package:task_manager/core/widgets/reusable_text.dart';

showAlretDialog({
  required BuildContext context,
  required String msg,
  String? buttonText,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        content: ReusableText(
          text: msg,
          style: reusableStyle(18, AppConst.light, FontWeight.w600),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              buttonText ?? 'OK',
              style: reusableStyle(18, AppConst.light, FontWeight.w600),
            ),
          ),
        ],
      );
    },
  );
}
