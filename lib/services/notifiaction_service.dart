import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class NotificationService {
  static final NotificationService _notificationService =
  NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future<void> initNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings("ic_launcher");
    const IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification(
      {required int id,
        required String title,
        required String body,}) async {
    await flutterLocalNotificationsPlugin.show(
        id,
        title,
        body,
        const NotificationDetails(
            android: AndroidNotificationDetails('main_channel', "Main_channel",
                importance: Importance.max, priority: Priority.max),
            iOS: IOSNotificationDetails(
              sound: 'default.wav',
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
            )));
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}