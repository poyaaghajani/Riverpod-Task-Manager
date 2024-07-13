import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:task_manager/core/constants/constants.dart';
import 'package:task_manager/core/widgets/gap.dart';
import 'package:task_manager/core/widgets/reusable_style.dart';
import 'package:task_manager/core/widgets/reusable_text.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({
    super.key,
    this.color,
    this.title,
    this.description,
    this.start,
    this.end,
    this.editWidget,
    this.delete,
    this.switcher,
  });

  final Color? color;
  final String? title;
  final String? description;
  final String? start;
  final String? end;
  final Widget? editWidget;
  final void Function()? delete;
  final Widget? switcher;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Stack(
        children: [
          Container(
            width: AppConst.appWidth,
            padding: EdgeInsets.all(8.h),
            decoration: BoxDecoration(
              color: AppConst.greyLight,
              borderRadius: BorderRadius.circular(AppConst.radius),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 80.h,
                      width: 5.w,
                      color: color ?? AppConst.red,
                    ),
                    Gap(width: 15.w),
                    Padding(
                      padding: EdgeInsets.all(8.h),
                      child: SizedBox(
                        width: AppConst.appWidth * 0.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableText(
                              text: title ?? "Title of Todo",
                              style: reusableStyle(
                                  18, AppConst.light, FontWeight.bold),
                            ),
                            Gap(height: 3.h),
                            ReusableText(
                              text: description ?? "Description of Todo",
                              style: reusableStyle(
                                  12, AppConst.light, FontWeight.bold),
                            ),
                            Gap(height: 10.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: AppConst.appWidth * 0.3,
                                  height: 25.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 0.3,
                                      color: AppConst.greyDark,
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(AppConst.radius),
                                    color: AppConst.dark,
                                  ),
                                  child: Center(
                                    child: ReusableText(
                                      text: '$start | $end',
                                      style: reusableStyle(
                                        12,
                                        AppConst.light,
                                        FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                                const Gap(width: 20),
                                Row(
                                  children: [
                                    SizedBox(
                                      child: editWidget,
                                    ),
                                    const Gap(width: 20),
                                    GestureDetector(
                                      onTap: delete,
                                      child: const Icon(
                                        MaterialCommunityIcons.delete_circle,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: switcher,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
