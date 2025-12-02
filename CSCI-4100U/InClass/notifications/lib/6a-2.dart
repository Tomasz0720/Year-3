// Import the core Flutter Material Design library — provides UI components and themes
import 'package:flutter/material.dart';

// Import plugin for handling local (on-device) notifications
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Import to detect which OS the app is running on (Android or iOS)
import 'dart:io' show Platform;

// Import package for requesting runtime permissions (e.g., Android 13+ notification permission)
import 'package:permission_handler/permission_handler.dart';


// =====================
// MAIN ENTRY POINT
// =====================
void main() {
  // runApp() inflates the root widget of the app and attaches it to the screen
  runApp(MyApp());
}


// =====================
// ROOT WIDGET (Stateless)
// =====================
// Defines the high-level app configuration such as theme and home screen
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notification Demo', // App name shown in task switcher
      theme: ThemeData(primarySwatch: Colors.blue), // Sets global color theme
      home: NotificationPage(), // The first screen displayed when the app launches
    );
  }
}


// =====================
// STATEFUL PAGE
// =====================
// Because we’ll update state when showing notifications or requesting permission
class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}


// =====================
// STATE CLASS
// =====================
// Contains the mutable logic and setup for notification handling
class _NotificationPageState extends State<NotificationPage> {
  // The plugin object responsible for creating, scheduling, and managing notifications
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;


  // -------------------------------
  // INIT STATE — runs once on widget creation
  // -------------------------------
  @override
  void initState() {
    super.initState();

    // Step 1: Initialize the notifications plugin
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // Step 2: Define platform-specific initialization (Android)
    // Uses the app launcher icon for notifications
    // It defines how notifications behave on Android when your app starts
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    // Combine all platform initialization settings
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      // iOS config could also be added here if needed
    );

    // Step 3: Initialize the plugin with settings and callback handler
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        // Runs when the user taps the notification
        onSelectNotification(notificationResponse.payload); //user defined method (block of code)
        print("Notification tapped!");
      },
    );

    // Step 4: Request notification permission dynamically (Android 13+)
    if (Platform.isAndroid) {
      _requestNotificationPermission();
    }
  }


  // -------------------------------
  // PERMISSION HANDLING
  // -------------------------------
  // Requests permission for notifications on Android 13+ devices
  Future<void> _requestNotificationPermission() async {
    if (Platform.isAndroid) {
      // Check if permission hasn’t been granted yet
      if (await Permission.notification.isDenied) {
        // Ask the user for notification permission
        PermissionStatus status = await Permission.notification.request();

        // Log the result (for debugging)
        if (status.isDenied) {
          print("Notification permission denied");
        } else if (status.isGranted) {
          print("Notification permission granted");
        }
      }
    }
  }


  // -------------------------------
  // NOTIFICATION TAP HANDLER
  // -------------------------------
  // Called when user taps on the notification banner
  Future<void> onSelectNotification(String? payload) async {
    if (payload != null) {
      print('Notification payload received: $payload');
      // Here you could navigate to another screen based on payload info
    }
  }


  // -------------------------------
  // SHOW SIMPLE NOTIFICATION
  // -------------------------------
  // Creates and displays a basic local notification immediately
  Future<void> showNotification() async {
    // Define Android notification channel details
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id',          // Unique ID for grouping similar notifications
      'your_channel_name',        // Human-readable name shown in settings
      channelDescription:
      'your channel description', // Shown in Android system settings
      importance: Importance.max, // Makes the notification pop up
      priority: Priority.high,    // Ensures prompt delivery
    );

    //  platform-specific notification settings
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    // Actually show the notification
    await flutterLocalNotificationsPlugin.show(
      0,                           // Notification ID (0 = first)
      'Hello!',                    // Title text
      'This is a simple notification.', // Body text
      platformChannelSpecifics,    // Config defined above
      payload: 'Notification Payload', // Optional string passed on tap
    );
  }


  // -------------------------------
  // BUILD METHOD (UI)
  // -------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Demo'), // AppBar title text
      ),
      body: Center(
        // Main button that triggers a notification when pressed
        child: ElevatedButton(
          onPressed: showNotification, // Connects button press to function
          child: Text('Show Notification'), // Label shown on the button
        ),
      ),
    );
  }
}
