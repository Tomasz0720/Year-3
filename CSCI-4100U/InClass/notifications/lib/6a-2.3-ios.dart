// =====================
// IMPORTS
// =====================

// Flutter's Material UI package
import 'package:flutter/material.dart';

// Plugin for local (on-device) notifications
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Detect whether we are running on iOS or Android
import 'dart:io' show Platform;

// Permission handler for requesting runtime permissions
import 'package:permission_handler/permission_handler.dart';


// =====================
// MAIN ENTRY POINT
// =====================
void main() {
  runApp(MyApp());
}


// =====================
// ROOT WIDGET
// =====================
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iOS Notification Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: NotificationPage(), // First screen to load
    );
  }
}


// =====================
// STATEFUL PAGE
// =====================
class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}


// =====================
// STATE CLASS
// =====================
class _NotificationPageState extends State<NotificationPage> {
  // The plugin object that manages showing, scheduling, and responding to notifications
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();

    // Step 1: Create the plugin instance
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // Step 2: Define iOS-specific initialization settings
    const DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
      // These booleans control whether permission prompts appear automatically
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    // Step 3: Define Android-specific initialization (still required for cross-platform builds)
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    // Step 4: Combine both platform initialization settings
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    // Step 5: Initialize the plugin with the combined settings
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        // Called when the user taps on a delivered notification
        onSelectNotification(notificationResponse.payload);
        print("Notification tapped!");
      },
    );

    // Step 6: Ask for notification permission depending on the platform
    if (Platform.isIOS) {
      _requestIOSPermissions(); // iOS-specific permission flow
    } else if (Platform.isAndroid) {
      _requestAndroidPermissions(); // Android 13+ specific permission
    }
  }

  // -------------------------------
  // PERMISSION HANDLING FOR IOS
  // -------------------------------
  Future<void> _requestIOSPermissions() async {
    // Access the iOS-specific plugin interface
    final IOSFlutterLocalNotificationsPlugin? iosImplementation =
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();

    // Request permission for alert, badge, and sound
    final bool? granted = await iosImplementation?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Log result
    if (granted == true) {
      print("iOS notification permission granted");
    } else {
      print("iOS notification permission denied");
    }
  }

  // -------------------------------
  // PERMISSION HANDLING FOR ANDROID 13+
  // -------------------------------
  Future<void> _requestAndroidPermissions() async {
    if (await Permission.notification.isDenied) {
      PermissionStatus status = await Permission.notification.request();
      if (status.isGranted) {
        print("Android notification permission granted");
      } else {
        print("Android notification permission denied");
      }
    }
  }

  // -------------------------------
  // NOTIFICATION TAP HANDLER
  // -------------------------------
  Future<void> onSelectNotification(String? payload) async {
    if (payload != null) {
      print('Notification payload received: $payload');
      // You can navigate to a new screen here if needed
    }
  }

  // -------------------------------
  // SHOW SIMPLE NOTIFICATION
  // -------------------------------
  Future<void> showNotification() async {
    // Android notification channel details
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id', // Unique channel ID
      'your_channel_name', // Channel name
      channelDescription: 'Notification demo channel',
      importance: Importance.max,
      priority: Priority.high,
    );

    // iOS notification details
    const DarwinNotificationDetails iosPlatformChannelSpecifics =
    DarwinNotificationDetails(
      presentAlert: true, // Show alert banner
      presentBadge: true, // Update app icon badge
      presentSound: true, // Play notification sound
    );

    // Combine platform details
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosPlatformChannelSpecifics,
    );

    // Show the notification
    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      'Hello iOS!', // Notification title
      'This is a local notification on iOS.', // Notification body
      platformChannelSpecifics, // Combined details
      payload: 'Notification Payload', // Optional data
    );
  }

  // -------------------------------
  // BUILD METHOD (UI)
  // -------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('iOS Notification Demo')),
      body: Center(
        child: ElevatedButton(
          onPressed: showNotification,
          child: Text('Show Notification'),
        ),
      ),
    );
  }
}
