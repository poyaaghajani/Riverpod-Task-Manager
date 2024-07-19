// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager/config/routes/app_route.dart';
import 'package:task_manager/core/helpers/db_helper.dart';
import 'package:task_manager/core/utils/show_dialog.dart';
import 'package:task_manager/features/auth/pages/login_page.dart';
import 'package:task_manager/features/auth/pages/otp_page.dart';
import 'package:task_manager/features/todo/pages/home_page.dart';

final authReposytoryProvider =
    Provider((ref) => AuthReposytory(auth: FirebaseAuth.instance));

class AuthReposytory {
  final FirebaseAuth auth;

  AuthReposytory({required this.auth});

  Future<void> verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String smsCode,
  }) async {
    try {
      final credential = PhoneAuthProvider.credential(
        smsCode: smsCode,
        verificationId: verificationId,
      );

      await auth.signInWithCredential(credential);

      DbHelper.createUser(1);
      context.pushAndRemoveUntil(const HomePage());
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'invalid-verification-code':
          errorMessage = 'The verification code is invalid. Please try again.';
          break;
        default:
          errorMessage =
              'An unexpected error occurred. Please try again later.';
      }
      showAlretDialog(
        context: context,
        msg: errorMessage,
        barrierDismissible: false,
        onPressed: () {
          context.pushAndRemoveUntil(const LoginPage());
        },
      );
    } catch (e) {
      showAlretDialog(
        context: context,
        msg: 'An unexpected error occurred: $e',
        barrierDismissible: false,
        onPressed: () {
          context.pushAndRemoveUntil(const LoginPage());
        },
      );
    }
  }

  Future<void> sendOtp({
    required BuildContext context,
    required String phone,
  }) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          showAlretDialog(context: context, msg: e.toString());
        },
        codeSent: (String verificationId, int? resendToken) {
          context.pushAndRemoveUntil(
              OtpPage(phone: phone, verificationId: verificationId));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } on FirebaseAuth catch (e) {
      if (context.mounted) {
        showAlretDialog(context: context, msg: e.toString());
      }
    }
  }
}
