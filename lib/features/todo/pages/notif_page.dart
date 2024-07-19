import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/constants/constants.dart';
import 'package:task_manager/core/widgets/gap.dart';
import 'package:task_manager/core/widgets/reusable_style.dart';
import 'package:task_manager/core/widgets/reusable_text.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key, this.payload});

  final String? payload;

  @override
  Widget build(BuildContext context) {
    var title = payload!.split('|')[0];
    var desc = payload!.split('|')[1];
    var startTime = payload!.split('|')[3];
    var endTime = payload!.split('|')[4];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Container(
                width: AppConst.appWidth,
                height: AppConst.appHeight * 0.7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppConst.radius),
                  color: AppConst.lightBk,
                ),
                child: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(
                        text: 'Reminder',
                        style: reusableStyle(
                          40,
                          AppConst.light,
                          FontWeight.bold,
                        ),
                      ),
                      Gap(height: 5.h),
                      Container(
                        width: AppConst.appWidth,
                        padding: EdgeInsets.only(left: 5.w),
                        decoration: BoxDecoration(
                          color: AppConst.yellow,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ReusableText(
                              text: 'Today',
                              style: reusableStyle(
                                14,
                                AppConst.dark,
                                FontWeight.bold,
                              ),
                            ),
                            Gap(width: 15.h),
                            ReusableText(
                              text: 'From: $startTime To: $endTime',
                              style: reusableStyle(
                                14,
                                AppConst.dark,
                                FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap(height: 10.h),
                      ReusableText(
                        text: title,
                        style: reusableStyle(
                          30,
                          AppConst.dark,
                          FontWeight.w600,
                        ),
                      ),
                      Gap(height: 10.h),
                      Text(
                        desc,
                        maxLines: 8,
                        textAlign: TextAlign.justify,
                        style: reusableStyle(
                          16,
                          AppConst.light,
                          FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: -12.h,
              right: 12.w,
              child: Image.asset(
                AppConst.bell,
                width: 70.w,
                height: 70.h,
              ),
            ),
            Positioned(
              bottom: -AppConst.appHeight * 0.142,
              left: 0,
              right: 0,
              child: Image.asset(
                AppConst.notification,
                width: AppConst.appWidth * 0.8,
                height: AppConst.appHeight * 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
