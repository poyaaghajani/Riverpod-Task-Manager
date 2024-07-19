import 'package:flutter/material.dart';
import 'package:task_manager/core/constants/constants.dart';
import 'package:task_manager/core/widgets/reusable_style.dart';

showAlretDialog({
  required BuildContext context,
  required String msg,
  String? buttonText,
  bool barrierDismissible = true,
  void Function()? onPressed,
}) {
  return showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (context) {
      return AlertDialog(
        contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        content: Text(
          msg,
          style: reusableStyle(18, AppConst.light, FontWeight.w600),
        ),
        actions: [
          TextButton(
            onPressed: onPressed ?? () => Navigator.pop(context),
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
