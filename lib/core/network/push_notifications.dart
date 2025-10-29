import 'package:fint/core/constants/exports.dart';
import 'package:fint/core/network/globalkey.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io';

@pragma('vm:entry-point')
Future<void> firebaseBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message: ${message.messageId}');
}

FirebaseMessaging messaging = FirebaseMessaging.instance;
FlutterLocalNotificationsPlugin fltNotification =
    FlutterLocalNotificationsPlugin();
int id = 0;
SharedPref _pref = SharedPref();

var androidInit = const AndroidInitializationSettings('@mipmap/ic_launcher');
var iosInit = const DarwinInitializationSettings(
  defaultPresentAlert: true,
  defaultPresentBadge: true,
  defaultPresentSound: true,
);
var initSetting = InitializationSettings(android: androidInit, iOS: iosInit);

Future<void> _showGeneralNotification(
  Map<String, dynamic> message,
  RemoteNotification notification,
) async {
  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
    'notification_1',
    'general notification',
    channelDescription: 'general notification',
    enableVibration: true,
    enableLights: true,
    importance: Importance.high,
    playSound: true,
    priority: Priority.high,
    visibility: NotificationVisibility.public,
  );
  const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );
  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
    iOS: iosDetails,
  );
  await fltNotification.show(
    id++,
    message['title'],
    notification.body,
    notificationDetails,
    payload: 'general',
  );
}

void notificationTapBackground(NotificationResponse response) {
  navigatorKey.currentState?.push(
    MaterialPageRoute(builder: (context) => NotificationScreen()),
  );
}

Future<void> initMessaging() async {
  FirebaseMessaging.onBackgroundMessage(firebaseBackgroundHandler);

  await fltNotification.initialize(
    initSetting,
    onDidReceiveNotificationResponse: notificationTapBackground,
    onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
  );

  NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (Platform.isIOS) {
    String? apnsToken;
    int retries = 0;
    while (apnsToken == null && retries < 5) {
      apnsToken = await FirebaseMessaging.instance.getAPNSToken();
      await Future.delayed(const Duration(seconds: 1));
      retries++;
    }
    if (apnsToken == null) return;
  }

  final token = await FirebaseMessaging.instance.getToken();
  if (token != null) {
    await _pref.storeDeviceToken(token);
  }

  FirebaseMessaging.instance.getInitialMessage().then((message) {
    if (message != null && message.data['push_type'] == 'general') {
      navigatorKey.currentState?.push(
        MaterialPageRoute(builder: (context) => NotificationScreen()),
      );
    }
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    if (notification != null) {
      _showGeneralNotification(message.data, notification);
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (context) => NotificationScreen()),
    );
  });
}

var androidDetails = const AndroidNotificationDetails(
  '54321',
  'normal_notification',
  enableVibration: true,
  enableLights: true,
  importance: Importance.high,
  playSound: true,
  priority: Priority.high,
  visibility: NotificationVisibility.private,
);

const iosDetails = DarwinNotificationDetails(
  presentAlert: true,
  presentBadge: true,
  presentSound: true,
);

var generalNotificationDetails = NotificationDetails(
  android: androidDetails,
  iOS: iosDetails,
);
