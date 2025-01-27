import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:task_manager/core/constants/constants.dart';
import 'package:task_manager/core/widgets/reusable_style.dart';
import 'package:task_manager/core/widgets/reusable_text.dart';
import 'package:task_manager/features/auth/controllers/auth_controller.dart';

class OtpPage extends ConsumerWidget {
  const OtpPage({
    super.key,
    required this.phone,
    required this.verificationId,
  });

  final String phone;
  final String verificationId;

  void verifyOtpCode({
    required BuildContext context,
    required WidgetRef ref,
    required String smsCode,
  }) {
    ref.read(authProvider.notifier).verifyOtp(
          context: context,
          verificationId: verificationId,
          smsCode: smsCode,
          mounted: true,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var authState = ref.watch(authProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: AppConst.appHeight * 0.12),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Image.asset(
                  AppConst.todo,
                  width: AppConst.appWidth * 0.6,
                ),
              ),
              const SizedBox(height: 26),
              ReusableText(
                text: 'Enter your OTP code',
                style: reusableStyle(18, AppConst.light, FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Pinput(
                length: 6,
                showCursor: true,
                onCompleted: (value) {
                  if (value.length == 6) {
                    return verifyOtpCode(
                      context: context,
                      ref: ref,
                      smsCode: value,
                    );
                  }
                },
                onSubmitted: (value) {
                  if (value.length == 6) {
                    return verifyOtpCode(
                      context: context,
                      ref: ref,
                      smsCode: value,
                    );
                  }
                },
              ),
              if (authState.isVerifyLoading) ...[
                SizedBox(height: 20.h),
                const Center(
                  child: CircularProgressIndicator(
                    color: AppConst.light,
                  ),
                )
              ],
            ],
          ),
        ),
      ),
    );
  }
}
