import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

// Import your Notifications helper
import 'notifications.dart'; // adjust path if needed

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize timezone database (needed for scheduling)
  tz.initializeTimeZones();

  // Create and initialize your Notifications instance
  final notif = Notifications();
  await notif.init();

  runApp(MyApp(notif: notif));
}

class MyApp extends StatelessWidget {
  final Notifications notif;
  const MyApp({required this.notif, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notification Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: NotificationDemoPage(notif: notif),
    );
  }
}

class NotificationDemoPage extends StatelessWidget {
  final Notifications notif;
  const NotificationDemoPage({required this.notif, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notification Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                notif.sendNotificationNow(
                  "Immediate Notification",
                  "This one shows up right away!",
                  "instant_payload",
                );
              },
              child: const Text("Send Now"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final scheduledTime =
                tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10));
                notif.sendNotificationLater(
                  "Scheduled Notification",
                  "This will appear in 10 seconds!",
                  "scheduled_payload",
                  scheduledTime,
                );
              },
              child: const Text("Schedule 10s Later"),
            ),
          ],
        ),
      ),
    );
  }
}
