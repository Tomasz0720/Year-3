import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'; // For handling local notifications
import 'dart:async';  // For countdown functionality
import 'dart:io' show Platform; // For checking the platform (iOS or Android)
import 'package:permission_handler/permission_handler.dart'; // For managing permissions (especially for Android 13+)
import 'package:timezone/timezone.dart' as tz;  // Timezone package to manage scheduling notifications

// Main function: Entry point of the application
void main() {
  runApp(MyApp()); // Starts the root widget (MyApp)
}

// Root widget of the app
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notification Demo',  // App title
      theme: ThemeData(
        primarySwatch: Colors.blue,  // Theme color of the app
      ),
      home: NotificationPage(),  // Sets the home page of the app
    );
  }
}

// Stateful widget for handling notifications
class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

// Mutable state class for NotificationPage
class _NotificationPageState extends State<NotificationPage> {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;  // Plugin for handling notifications
  int _countdown = 3;  // Countdown timer set to 3 seconds
  Timer? _timer;  // Timer instance to manage countdown

  @override
  void initState() {
    super.initState();

    // Initialize the notifications plugin
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // Android-specific initialization settings for the notification plugin
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');  // The app icon used in the notification

    // Initialization settings for all platforms (only Android here)
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    // Initialize the plugin with settings and define behavior when the notification is tapped
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {
        onSelectNotification(notificationResponse.payload);  // Handle tap on notification
      },
    );

    // Request permission for Android 13+ users
    if (Platform.isAndroid) {
      _requestNotificationPermission();
    }
  }

  // Request permission for notifications on Android 13+
  Future<void> _requestNotificationPermission() async {
    if (Platform.isAndroid) {
      if (await Permission.notification.isDenied) {
        // If notification permission is denied, request it
        PermissionStatus status = await Permission.notification.request();
        if (status.isDenied) {
          print("Notification permission denied");
        } else if (status.isGranted) {
          print("Notification permission granted");
        }
      }
    }
  }

  // Method to handle what happens when a notification is tapped
  Future<void> onSelectNotification(String? payload) async {
    if (payload != null) {
      print('Notification payload: $payload');  // Log the payload if the notification is tapped
    }
  }

  // Method to show a notification after a 3-second countdown
  Future<void> showNotificationWithCountdown() async {
    _startCountdown();  // Start the countdown

    // Delay the notification for 3 seconds
    await Future.delayed(Duration(seconds: 3), () async {
      // Define notification details for Android
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
        'your_channel_id',  // Unique channel ID
        'your_channel_name',  // Name of the notification channel
        channelDescription: 'your channel description',  // Description of the channel
        importance: Importance.max,  // High importance to display the notification immediately
        priority: Priority.high,  // High priority to pop-up the notification
      );

      // Combine the notification details into NotificationDetails
      const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
      );

      // Show the notification
      await flutterLocalNotificationsPlugin.show(
        0,  // Notification ID (0 for simplicity)
        'Notification!',  // Title of the notification
        'This notification was triggered after a 3-second delay.',  // Body of the notification
        platformChannelSpecifics,  // Notification details
        payload: 'Notification Payload',  // Optional payload for notification taps
      );
    });
  }

  // Countdown timer function to update the UI every second
  void _startCountdown() {
    setState(() {
      _countdown = 3;  // Reset countdown to 3 seconds
    });

    // Create a periodic timer that updates the countdown every second
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 1) {
          _countdown -= 1;  // Decrease countdown by 1 every second
        } else {
          _countdown = 0;  // When countdown reaches zero
          _timer?.cancel();  // Stop the timer
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();  // Cancel the timer when the widget is disposed
    super.dispose();
  }

  // Method to schedule a daily notification (e.g., for "Dinner Time" at 5:30 PM)
  Future<void> scheduleDailyNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'daily_channel_id',  // Channel ID for daily notifications
      'Daily Notifications',  // Channel name
      channelDescription: 'Daily notifications at specific times',  // Channel description
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    // Schedule the daily notification at 5:30 PM
    await flutterLocalNotificationsPlugin.zonedSchedule(
      1,  // Unique ID for the scheduled notification
      'Dinner Time',  // Notification title
      'It\'s dinner time!',  // Notification body
      _nextInstanceOfTime(17, 30),  // Function to get the next instance of 5:30 PM
      platformChannelSpecifics,  // Notification details

      //Without this, it would only trigger once.
      // Schedule the notification at the same time every day
      matchDateTimeComponents: DateTimeComponents.time,

      //Use actual local clock time (as opposed to absolute UTC time).
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.wallClockTime,
    );
  }

  // Helper method to calculate the next instance of a specific time (e.g., 5:30 PM)
  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);  // Get current time
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);  // Set the time for today
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(Duration(days: 1));  // If the time has passed for today, schedule for tomorrow
    }
    return scheduledDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Demo'),  // App bar title
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,  // Center the column
          children: [
            Text(
              'Countdown: $_countdown',  // Display the countdown timer
              style: TextStyle(fontSize: 24),  // Font size for countdown text
            ),
            SizedBox(height: 20),  // Add space between the countdown and button
            ElevatedButton(
              onPressed: showNotificationWithCountdown,  // Start countdown and show notification
              child: Text('Show Notification After 3 Seconds'),  // Button label
            ),
            SizedBox(height: 20),  // Add space between buttons
            ElevatedButton(
              onPressed: scheduleDailyNotification,  // Schedule daily notification
              child: Text('Schedule Daily Dinner Reminder at 5:30 PM'),  // Button label
            ),
          ],
        ),
      ),
    );
  }
}
