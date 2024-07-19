import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager/features/auth/repository/auth_repository.dart';

final authProvider = StateNotifierProvider<AuthController, AuthState>((ref) {
  final authRepository = ref.watch(authReposytoryProvider);
  return AuthController(authRepository: authRepository);
});

class AuthState {
  final bool isSendLoading;
  final bool isVerifyLoading;

  AuthState({this.isSendLoading = false, this.isVerifyLoading = false});

  // Create a copyWith method to create a new instance with updated values
  AuthState copyWith({bool? isSendLoading, bool? isVerifyLoading}) {
    return AuthState(
      isSendLoading: isSendLoading ?? this.isSendLoading,
      isVerifyLoading: isVerifyLoading ?? this.isVerifyLoading,
    );
  }
}

class AuthController extends StateNotifier<AuthState> {
  final AuthReposytory authRepository;

  AuthController({required this.authRepository}) : super(AuthState());

  void verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String smsCode,
    required bool mounted,
  }) async {
    state = state.copyWith(isVerifyLoading: true);

    await authRepository.verifyOtp(
      context: context,
      verificationId: verificationId,
      smsCode: smsCode,
    );
    Future.delayed(const Duration(seconds: 1), () {
      state = state.copyWith(isVerifyLoading: false);
    });
  }

  void sendSms({
    required BuildContext context,
    required String phone,
  }) async {
    state = state.copyWith(isSendLoading: true);

    await authRepository.sendOtp(context: context, phone: phone);

    Future.delayed(const Duration(minutes: 1), () {
      state = state.copyWith(isSendLoading: false);
    });
  }
}
