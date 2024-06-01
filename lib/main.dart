import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager/config/theme/app_theme.dart';
import 'package:task_manager/features/onboarding/pages/onboarding_page.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      minTextAdapt: true,
      designSize: const Size(392, 802),
      builder: (context, child) {
        return MaterialApp(
          theme: appTheme,
          themeMode: ThemeMode.dark,
          debugShowCheckedModeBanner: false,
          home: const OnBoardingPage(),
        );
      },
    );
  }
}
