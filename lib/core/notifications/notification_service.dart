import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

// ignore_for_file: avoid_print

/// Singleton service for scheduling per-habit local notifications.
///
/// Android setup required in AndroidManifest.xml:
///   <uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM"/>
///   <uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
///
/// And inside <application>:
///   <receiver android:exported="false"
///     android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationReceiver"/>
class NotificationService {
  NotificationService._();
  static final instance = NotificationService._();

  final _plugin = FlutterLocalNotificationsPlugin();

  static const _channelId = 'habit_reminders';
  static const _channelName = 'Habit Reminders';
  static const _channelDesc = 'Daily reminders for your habits';

  Future<void> initialize() async {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize(settings);

    // Request Android 13+ notification permission.
    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  /// Schedule a daily notification for [habitId] at the given [timeHHmm].
  Future<void> scheduleHabitReminder({
    required int habitId,
    required String habitName,
    required String timeHHmm,
  }) async {
    await cancelHabitReminder(habitId);

    final parts = timeHHmm.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);

    final now = tz.TZDateTime.now(tz.local);
    var scheduled =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);

    // If the time already passed today, schedule for tomorrow.
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        _channelId,
        _channelName,
        channelDescription: _channelDesc,
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );

    await _plugin.zonedSchedule(
      habitId,
      'Time for your habit!',
      habitName,
      scheduled,
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time, // repeat daily
    );
  }

  Future<void> cancelHabitReminder(int habitId) async {
    await _plugin.cancel(habitId);
  }

  Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }
}
