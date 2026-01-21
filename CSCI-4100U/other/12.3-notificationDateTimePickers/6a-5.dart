import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() {
  tz.initializeTimeZones();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: NotificationApp());
  }
}

class NotificationApp extends StatefulWidget {
  @override
  _NotificationAppState createState() => _NotificationAppState();
}

class _NotificationAppState extends State<NotificationApp> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  int _id = 0;

  @override
  void initState() {
    super.initState();

    // Android-only init (add iOS if you need it)
    const initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _scheduleNotification(DateTime scheduledDate) async {
    const androidDetails = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'channel_description',
      icon: 'app_icon',
      importance: Importance.max,
      priority: Priority.high,
    );

    const details = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      _id++,
      'Scheduled Notification',
      'This is coming at ${scheduledDate.hour}:${scheduledDate.minute.toString().padLeft(2, '0')}:${scheduledDate.second.toString().padLeft(2, '0')}',
      tz.TZDateTime.from(scheduledDate, tz.local),
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notification App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Schedule after 3 seconds
            ElevatedButton(
              onPressed: () {
                final when =
                tz.TZDateTime.now(tz.local).add(const Duration(seconds: 3));
                _scheduleNotification(when);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Notification in 3 seconds scheduled')),
                );
              },
              child: const Text('Send Notification in 3 seconds'),
            ),
            const SizedBox(height: 16),
            // Pick date & time
            ElevatedButton(
              onPressed: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                final pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (pickedDate != null && pickedTime != null) {
                  final scheduled = DateTime(
                    pickedDate.year,
                    pickedDate.month,
                    pickedDate.day,
                    pickedTime.hour,
                    pickedTime.minute,
                  );
                  await _scheduleNotification(scheduled);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Notification scheduled for ${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')} '
                            '${pickedTime.format(context)}',
                      ),
                    ),
                  );
                }
              },
              child: const Text('Pick Date & Time for Notification'),
            ),
          ],
        ),
      ),
    );
  }
}
