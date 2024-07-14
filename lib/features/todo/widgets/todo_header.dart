import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:task_manager/config/routes/app_route.dart';
import 'package:task_manager/core/constants/constants.dart';
import 'package:task_manager/core/widgets/gap.dart';
import 'package:task_manager/core/widgets/reusable_style.dart';
import 'package:task_manager/core/widgets/reusable_text.dart';
import 'package:task_manager/features/todo/pages/add_page.dart';

class ToDoHeader extends StatelessWidget {
  const ToDoHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          FontAwesome.tasks,
          size: 20,
          color: AppConst.light,
        ),
        const Gap(width: 10),
        ReusableText(
          text: 'Todays Tasks',
          style: reusableStyle(18, AppConst.light, FontWeight.bold),
        ),
        const Spacer(),
        Container(
          width: 30.w,
          height: 30.h,
          decoration: BoxDecoration(
            color: AppConst.light,
            borderRadius: BorderRadius.circular(4),
          ),
          child: GestureDetector(
            onTap: () {
              context.push(const AddTaskPage());
            },
            child: const Icon(
              Icons.add,
              color: AppConst.dark,
            ),
          ),
        ),
      ],
    );
  }
}
