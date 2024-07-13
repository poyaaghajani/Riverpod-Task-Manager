import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/constants/constants.dart';
import 'package:task_manager/core/widgets/reusable_style.dart';
import 'package:task_manager/core/widgets/reusable_text.dart';

class OnBoardingOne extends StatelessWidget {
  const OnBoardingOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppConst.appHeight,
      width: AppConst.appWidth,
      color: AppConst.dark,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Image.asset(AppConst.todo),
          ),
          const SizedBox(height: 100),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ReusableText(
                text: "TODO with Riverpod",
                style: reusableStyle(30, AppConst.light, FontWeight.w600),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Text(
                  "Wellcome! Do you want to create a task fast and with ease",
                  textAlign: TextAlign.center,
                  style: reusableStyle(16, AppConst.greyLight, FontWeight.w500),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
