import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nabd/core/utls/app_navigator.dart';
import 'package:nabd/features/chats/presentation/view_models/cubit.dart';
import 'package:nabd/features/chats/presentation/views/screens/chat_details_screen.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await NotificationService.instance.setupFlutterNotification();
  await NotificationService.instance.showNotification(message);
}

class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  final _messaging = FirebaseMessaging.instance;
  final localNotifications = FlutterLocalNotificationsPlugin();
  bool _isFlutterLocalNotificationInitialized = false;

  Future<void> initialize() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Request permission
    await _requestPermission();

    // Setup message handlers
    await _setupMessageHandlers();

    // Get FCM token
    final token = await _messaging.getToken();
    print('FCM Token: $token');
  }

  Future<void> _requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
      announcement: false,
      carPlay: false,
      criticalAlert: false,
    );
    print('Permission Status : ${settings.authorizationStatus}');
  }

  Future<void> setupFlutterNotification() async {
    if (_isFlutterLocalNotificationInitialized) {
      return;
    }

    //android setup
    const channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );
    await localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);
    const initializationAndroidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    //ios setup
    final initializationSettingsDarwin = DarwinInitializationSettings();

    final initializationSettings = InitializationSettings(
      android: initializationAndroidSettings,
      iOS: initializationSettingsDarwin,
    );

    //flutter notification setup
    await localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        final payload = details.payload;
        if (payload != null) {
          final data = Map<String, dynamic>.from(jsonDecode(payload));
          handleBackgroundMessage(RemoteMessage(data: data));
        }
      },
    );

    _isFlutterLocalNotificationInitialized = true;
  }

  Future<void> showNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      await localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance Notifications',
            channelDescription:
                'This channel is used for important notifications.',
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: jsonEncode(message.data),
      );
    }
  }

  Future<void> _setupMessageHandlers() async {
    //foreground message
    FirebaseMessaging.onMessage.listen((message) {
      print('onMessage: ${message.notification?.title}');
      print('onMessage: ${message.notification?.body}');
      showNotification(message);
    });

    // background message
    FirebaseMessaging.onMessageOpenedApp.listen(handleBackgroundMessage);

    // opened app
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      handleBackgroundMessage(initialMessage);
    }
  }

  void handleBackgroundMessage(RemoteMessage message) {
    final data = message.data;

    if (data['type'] == 'chat') {
      final name = data['name'] ?? 'Unknown';
      final receiverId = data['receiverId'] ?? '';
      final imageUrl = int.parse(data['imageUrl']);

      AppNavigator.push(
        BlocProvider(
          create: (context) => ChatCubit(),
          child: ChatDetailsScreen(
            name: name,
            receiverId: receiverId,
            imageUrl: imageUrl,
          ),
        ),
      );
    }
  }
}
