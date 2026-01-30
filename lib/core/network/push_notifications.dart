import 'package:fint/core/constants/exports.dart';
import 'package:fint/core/network/globalkey.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
Future<void> firebaseBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print('Handling background message: ${message.messageId}');
  }
}

final FirebaseMessaging messaging = FirebaseMessaging.instance;
final FlutterLocalNotificationsPlugin fltNotification =
    FlutterLocalNotificationsPlugin();

final SharedPref _pref = SharedPref();
int notificationId = 0;

const AndroidInitializationSettings androidInit = AndroidInitializationSettings(
  '@mipmap/ic_launcher',
);

const DarwinInitializationSettings iosInit = DarwinInitializationSettings(
  defaultPresentAlert: true,
  defaultPresentBadge: true,
  defaultPresentSound: true,
);

const InitializationSettings initSetting = InitializationSettings(
  android: androidInit,
  iOS: iosInit,
);

Future<void> showGeneralNotification(
  Map<String, dynamic> data,
  RemoteNotification notification,
) async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'general_channel',
    'General Notifications',
    channelDescription: 'General app notifications',
    importance: Importance.high,
    priority: Priority.high,
    playSound: true,
    enableVibration: true,
    visibility: NotificationVisibility.public,
  );

  const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );

  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidDetails,
    iOS: iosDetails,
  );

  await fltNotification.show(
    notificationId++,
    notification.title,
    notification.body,
    notificationDetails,
    payload: jsonEncode(data),
  );
}

void onNotificationTap(NotificationResponse response) {
  if (response.payload == null || response.payload!.isEmpty) return;

  final Map<String, dynamic> data =
      jsonDecode(response.payload!) as Map<String, dynamic>;

  Future.microtask(() => handleNotificationNavigation(data));
}

void handleNotificationNavigation(Map<String, dynamic> data) {
  final String? pushType = data['push_type'] ?? data['notificationType'];

  debugPrint("PushType:$pushType");

  if (pushType == 'payment') {
    navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (_) => TransactionHistoryScreen()),
    );
  } else if (pushType == 'coupon') {
    navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (_) => CouponsScreen()),
    );
  } else {
    navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (_) => NotificationScreen()),
    );
  }
}

Future<void> initMessaging() async {
  FirebaseMessaging.onBackgroundMessage(firebaseBackgroundHandler);

  await fltNotification.initialize(
    initSetting,
    onDidReceiveNotificationResponse: onNotificationTap,
    onDidReceiveBackgroundNotificationResponse: onNotificationTap,
  );

  await messaging.requestPermission();

  final String? token = await messaging.getToken();
  await _pref.storeDeviceToken(token ?? '');

  final RemoteMessage? initialMessage = await FirebaseMessaging.instance
      .getInitialMessage();

  if (initialMessage != null) {
    Future.microtask(() {
      handleNotificationNavigation(initialMessage.data);
    });
  }

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    final notification = message.notification;
    if (notification != null) {
      if (kDebugMode) {
        print('Foreground notification: ${notification.body}');
      }
      showGeneralNotification(message.data, notification);
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    handleNotificationNavigation(message.data);
  });
}
