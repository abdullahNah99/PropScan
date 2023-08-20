import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:untitled/shared/network/local/cache_helper.dart';
import 'package:untitled/shared/network/remote/dio_helper.dart';
import 'package:untitled/shared/styles/app_colors.dart';
import 'package:untitled/shared/utils/app_router.dart';
import 'firebase_options.dart';
import 'modules/splash_screen/splash_screen.dart';

late Size screenSize;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeFirebase();
  await CacheHelper.init();
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return ScreenUtilInit(
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            useMaterial3: true,
            primaryColor: AppColors.createMaterialColor(AppColors.defaultColor),
            appBarTheme: AppBarTheme(
              // systemOverlayStyle: const SystemUiOverlayStyle(
              //   statusBarColor: AppColors.color2,
              // ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(22.r),
                ),
              ),
              color: AppColors.color2,
              centerTitle: true,
              iconTheme: const IconThemeData(
                color: Colors.white,
                size: 30,
              ),
              titleTextStyle: const TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
          ),
          // home: const TestMaps(),
          initialRoute: SplashView.route,
          routes: AppRouter.router,
        );
      },
    );
  }
}

_initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  var result = await FlutterNotificationChannel.registerNotificationChannel(
    description: 'For Showing Message Notification',
    id: 'chats',
    importance: NotificationImportance.IMPORTANCE_HIGH,
    name: 'Chats',
  );
  log('\nNotification Channel Result: $result');
}
