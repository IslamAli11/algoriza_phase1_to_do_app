import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;


const Color primaryColor = Colors.white;



class LocalNotification {
  LocalNotification();

  final localNotificationService = FlutterLocalNotificationsPlugin();

  final BehaviorSubject<String?> onNotificationClick = BehaviorSubject();

  Future<void> intialize() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings androidInitializationSettings =
    AndroidInitializationSettings('flutter');

    IOSInitializationSettings iosInitializationSettings =
    IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    final InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await localNotificationService.initialize(
      settings,
      onSelectNotification: onSelectNotification,
    );
  }

  Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('channel_id', 'channel_name',
        channelDescription: 'description',
        importance: Importance.max,
        priority: Priority.max,
        playSound: true);

    const IOSNotificationDetails iosNotificationDetails =
    IOSNotificationDetails();

    return const NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    final details = await _notificationDetails();
    await localNotificationService.show(id, title, body, details);
  }

  Future<void> showScheduledNotification(
      {required int id,
        required String title,
        required String body,
        required int minutes}) async {
    final details = await _notificationDetails();
    await localNotificationService.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(
        DateTime.now().add(Duration(minutes:minutes,)),
        tz.local,
      ),
      details,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );
  }


  Future<void> showNotificationWithPayload(
      {required int id,
        required String title,
        required String body,
        required String payload}) async {
    final details = await _notificationDetails();
    await localNotificationService.show(id, title, body, details,
        payload: payload);
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    debugPrint('id $id');
  }

  void onSelectNotification(String? payload) {
    debugPrint('payload $payload');
    if (payload != null && payload.isNotEmpty) {
      onNotificationClick.add(payload);
    }
  }

  cancelNotification( task) async {
    await localNotificationService.cancel(task['id']);
  }
  cancelAllNotification() async {
    await localNotificationService.cancelAll();
  }

}