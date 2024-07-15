import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager/config/routes/app_route.dart';
import 'package:task_manager/core/helpers/db_helper.dart';
import 'package:task_manager/core/utils/show_dialog.dart';
import 'package:task_manager/features/auth/pages/otp_page.dart';
import 'package:task_manager/features/todo/pages/home_page.dart';

final authReposytoryProvider =
    Provider((ref) => AuthReposytory(auth: FirebaseAuth.instance));

class AuthReposytory {
  final FirebaseAuth auth;

  AuthReposytory({required this.auth});

  void verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String smsCode,
    required bool mounted,
  }) async {
    try {
      final credential = PhoneAuthProvider.credential(
        smsCode: smsCode,
        verificationId: verificationId,
      );

      await auth.signInWithCredential(credential);
      if (!mounted) {
        return;
      } else {
        context.pushAndRemoveUntil(const HomePage());
      }
    } on FirebaseAuth catch (e) {
      showAlretDialog(context: context, msg: e.toString());
    }
  }

  void sendOtp({
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
          DbHelper.createUser(1);
          context.pushAndRemoveUntil(
              OtpPage(phone: phone, verificationId: verificationId));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } on FirebaseAuth catch (e) {
      showAlretDialog(context: context, msg: e.toString());
    }
  }
}
