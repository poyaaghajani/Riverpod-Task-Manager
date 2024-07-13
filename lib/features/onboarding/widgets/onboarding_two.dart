import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/config/routes/app_route.dart';
import 'package:task_manager/core/constants/constants.dart';
import 'package:task_manager/core/widgets/custom_outlined_btn.dart';
import 'package:task_manager/features/auth/pages/login_page.dart';

class OnBoardingTwo extends StatelessWidget {
  const OnBoardingTwo({super.key});

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
          const SizedBox(height: 50),
          CustomOutlinedBtn(
            onTap: () {
              context.push(const LoginPage());
            },
            height: AppConst.appHeight * 0.06,
            width: AppConst.appWidth * 0.9,
            color: AppConst.light,
            text: "Login with a phone number",
          ),
        ],
      ),
    );
  }
}
