import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager/core/constants/constants.dart';
import 'package:task_manager/core/helpers/notification_helper.dart';
import 'package:task_manager/core/models/user_model.dart';
import 'package:task_manager/features/auth/controllers/user_controller.dart';
import 'package:task_manager/features/onboarding/pages/onboarding_page.dart';
import 'package:task_manager/features/todo/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:task_manager/features/todo/pages/notif_page.dart';
import 'firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationHelper.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  var initialNotification =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  String? initialPayload;
  if (initialNotification?.didNotificationLaunchApp == true) {
    initialPayload = initialNotification?.notificationResponse?.payload;
  }

  runApp(
    ProviderScope(
      child: MyApp(initialPayload: initialPayload),
    ),
  );
}

class MyApp extends ConsumerWidget {
  final String? initialPayload;

  const MyApp({Key? key, this.initialPayload}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ref.read(userProvider.notifier).refresh(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.dark,
            darkTheme: ThemeData(
              scaffoldBackgroundColor: AppConst.dark,
              useMaterial3: true,
            ),
            home: const Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: AppConst.light,
                ),
              ),
            ),
          );
        } else {
          List<UserModel> users = ref.watch(userProvider);

          return ScreenUtilInit(
            useInheritedMediaQuery: true,
            minTextAdapt: true,
            designSize: const Size(392, 802),
            builder: (context, child) {
              return MaterialApp(
                navigatorKey: navigatorKey,
                darkTheme: ThemeData(
                  scaffoldBackgroundColor: AppConst.dark,
                  colorScheme: ColorScheme.fromSwatch(
                    primarySwatch: Colors.blue,
                    brightness: Brightness.dark,
                  ),
                  useMaterial3: true,
                ),
                themeMode: ThemeMode.dark,
                debugShowCheckedModeBanner: false,
                initialRoute: initialPayload != null
                    ? '/notification'
                    : users.isEmpty
                        ? '/onboarding'
                        : '/',
                routes: {
                  '/': (context) => const HomePage(),
                  '/onboarding': (context) => const OnBoardingPage(),
                  '/notification': (context) =>
                      NotificationPage(payload: initialPayload),
                },
              );
            },
          );
        }
      },
    );
  }
}
