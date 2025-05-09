import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nabd/core/service/notification_services.dart';
import 'package:nabd/core/utls/app_navigator.dart';
import 'package:nabd/core/variables/constant_variables.dart';
import 'package:nabd/features/authorization/data/models/user_model.dart';
import 'package:nabd/features/chats/data/models/rate_model.dart';
import 'package:nabd/features/layout/presentation/views/layout_screen.dart';
import 'core/utls/bloc_observer.dart';
import 'core/utls/cache_helper.dart';
import 'features/authorization/presentation/views/screen/who_are_you_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await NotificationService.instance.setupFlutterNotification();
  await NotificationService.instance.initialize();

  // Handle notification when app is terminated
  final launchDetails =
      await NotificationService.instance.localNotifications
          .getNotificationAppLaunchDetails();

  if (launchDetails?.didNotificationLaunchApp ?? false) {
    final payload = launchDetails!.notificationResponse?.payload;
    if (payload != null) {
      final data = Map<String, dynamic>.from(jsonDecode(payload));
      NotificationService.instance.handleBackgroundMessage(
        RemoteMessage(data: data),
      );
    }
  }

  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  await initializeDateFormatting('ar', null);
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(RateModelAdapter());

  await Hive.openBox<UserModel>('userModel');
  ConstantVariables.userData = Hive.box<UserModel>(
    'userModel',
  ).get('userModel');
  ConstantVariables.uId = CacheHelper.getData(key: 'uId') ?? '';
  ConstantVariables.guestuId = CacheHelper.getData(key: 'guestuId') ?? '';

  Widget firstScreen;
  if (CacheHelper.getData(key: 'userName').toString() == 'doctor' ||
      CacheHelper.getData(key: 'userName').toString() == 'Guest') {
    firstScreen = const LayoutScreen();
  } else {
    firstScreen = const WhoAreYouScreen();
  }
  runApp(MyApp(firstScreen: firstScreen));
}

class MyApp extends StatelessWidget {
  final Widget firstScreen;
  const MyApp({super.key, required this.firstScreen});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          navigatorKey: AppNavigator.navigatorKey,
          debugShowCheckedModeBanner: false,
          home: firstScreen,
        );
      },
    );
  }
}
