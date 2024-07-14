import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager/core/constants/constants.dart';
import 'package:task_manager/core/widgets/gap.dart';
import 'package:task_manager/core/widgets/reusable_style.dart';
import 'package:task_manager/core/widgets/reusable_text.dart';
import 'package:task_manager/features/todo/controllers/todo_provider.dart';

class BottomTitles extends StatelessWidget {
  const BottomTitles({
    super.key,
    required this.text,
    required this.text2,
    this.clr,
  });

  final String text;
  final String text2;
  final Color? clr;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppConst.appWidth,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Consumer(
              builder: (context, ref, child) {
                var color =
                    ref.read(toDoStateProvider.notifier).getRandomColor();

                return Container(
                  height: 80.h,
                  width: 5.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppConst.radius),
                    color: color,
                  ),
                );
              },
            ),
            const Gap(width: 15),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReusableText(
                    text: text,
                    style: reusableStyle(24, AppConst.light, FontWeight.bold),
                  ),
                  const Gap(height: 10),
                  ReusableText(
                    text: text2,
                    style: reusableStyle(12, AppConst.light, FontWeight.normal),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
