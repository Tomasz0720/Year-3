// Import the core Flutter Material Design library — provides UI components and themes
import 'package:flutter/material.dart';

// Import plugin for handling local (on-device) notifications
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Import to detect which OS the app is running on (Android or iOS)
import 'dart:io' show Platform;

// Import package for requesting runtime permissions (e.g., Android 13+ notification permission)
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notification Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: NotificationPage(),
    );
  }
}

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  // The plugin object responsible for creating, scheduling, and managing notifications
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();

    // TODO(1): Initialize the notifications plugin object
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // TODO(2): Android initialization settings (use launcher icon)
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    // TODO(3): Combine platform initialization settings
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      // iOS config could also be added here if needed
    );

    // TODO(4): Initialize the plugin and handle taps
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Runs when the user taps the notification
        onSelectNotification(response.payload);
        print("Notification tapped!");
      },
    );

    // TODO(5): Request notification permission dynamically (Android 13+)
    if (Platform.isAndroid) {
      _requestNotificationPermission();
    }
  }

  // Requests permission for notifications on Android 13+ devices
  Future<void> _requestNotificationPermission() async {
    if (Platform.isAndroid) {
      if (await Permission.notification.isDenied) {
        // TODO(6): Actually request the permission
        PermissionStatus status = await Permission.notification.request();

        if (status.isDenied) {
          print("Notification permission denied");
        } else if (status.isGranted) {
          print("Notification permission granted");
        }
      }
    }
  }

  // Called when user taps on the notification banner
  Future<void> onSelectNotification(String? payload) async {
    if (payload != null) {
      print('Notification payload received: $payload');
      // (Optional) Navigate based on payload
    }
  }

  // Creates and displays a basic local notification immediately
  Future<void> showNotification() async {
    // TODO(7): Define Android notification channel details
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id',                 // Channel ID
      'your_channel_name',               // Channel name
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
    );

    // TODO(8): Wrap platform-specific details
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    // TODO(9): Show the notification
    await flutterLocalNotificationsPlugin.show(
      0,                            // Notification ID
      'Hello!',                     // Title
      'This is a simple notification.', // Body
      platformChannelSpecifics,
      payload: 'Notification Payload',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          // TODO(10): Wire the button to trigger the notification
          onPressed: showNotification,
          child: Text('Show Notification'),
        ),
      ),
    );
  }
}
