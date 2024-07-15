import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager/features/auth/repository/auth_repository.dart';

final authProvider = Provider((ref) {
  final authReposytory = ref.watch(authReposytoryProvider);
  return AuthController(authReposytory: authReposytory);
});

class AuthController {
  final AuthReposytory authReposytory;

  AuthController({required this.authReposytory});

  void verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String smsCode,
    required bool mounted,
  }) {
    authReposytory.verifyOtp(
      context: context,
      verificationId: verificationId,
      smsCode: smsCode,
      mounted: mounted,
    );
  }

  void sendSms({
    required BuildContext context,
    required String phone,
  }) {
    authReposytory.sendOtp(context: context, phone: phone);
  }
}
