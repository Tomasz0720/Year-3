import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'; // Import to handle local notifications
import 'dart:async';  // Import to handle countdown functionality with Timer
import 'dart:io' show Platform; // Import to check the platform (iOS or Android)
import 'package:permission_handler/permission_handler.dart'; // Import to handle Android notification permissions (especially for Android 13+)

// Entry point of the application
void main() {
  runApp(MyApp()); // Runs the root widget (MyApp)
}

// Root widget of the app
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notification Demo',  // Title of the app
      theme: ThemeData(
        primarySwatch: Colors.blue,  // Theme color of the app
      ),
      home: NotificationPage(),  // Sets the NotificationPage as the home screen
    );
  }
}

// StatefulWidget to manage notifications and the countdown
class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

// Mutable state for NotificationPage
class _NotificationPageState extends State<NotificationPage> {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin; // Plugin to handle notifications
  int _countdown = 3; // Countdown timer set to 3 seconds
  Timer? _timer; // Timer instance to manage countdown

  @override
  void initState() {
    super.initState();

    // Initialize the FlutterLocalNotificationsPlugin
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // Android-specific initialization settings
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    // Combine all initialization settings
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    // Initialize the notifications plugin with settings
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // Handle what happens when notification is tapped
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {
        onSelectNotification(notificationResponse.payload);
      },
    );

    // Request notification permission for Android 13+
    if (Platform.isAndroid) {
      _requestNotificationPermission();
    }
  }

  // Method to request notification permission for Android 13 and above
  Future<void> _requestNotificationPermission() async {
    if (Platform.isAndroid) {
      // Check if permission is denied
      if (await Permission.notification.isDenied) {
        // Request permission from the user
        PermissionStatus status = await Permission.notification.request();
        if (status.isDenied) {
          print("Notification permission denied");  // Log if permission is denied
        } else if (status.isGranted) {
          print("Notification permission granted");  // Log if permission is granted
        }
      }
    }
  }

  // Method to handle what happens when a notification is tapped
  Future<void> onSelectNotification(String? payload) async {
    if (payload != null) {
      print('Notification payload: $payload');  // Log the payload when notification is tapped
    }
  }

  // Method to show notification after a 3-second countdown
  Future<void> showNotificationWithCountdown() async {
    _startCountdown();  // Start the countdown timer

    // Delay the notification for 3 seconds
    await Future.delayed(Duration(seconds: 3), () async {
      // Define notification details for Android
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
        'your_channel_id',  // Unique channel ID
        'your_channel_name',  // Name of the notification channel
        channelDescription: 'your channel description',  // Description of the channel
        importance: Importance.max,  // Importance level for the notification
        priority: Priority.high,  // High priority to pop up the notification
      );

      // Combine Android-specific details into NotificationDetails
      const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
      );

      // Show the notification
      await flutterLocalNotificationsPlugin.show(
        0,  // Notification ID (0 for simplicity)
        'Notification!',  // Title of the notification
        'This notification was triggered after a 3-second delay.',  // Body of the notification
        platformChannelSpecifics,  // Notification details
        payload: 'Notification Payload',  // Additional data sent with the notification
      );
    });
  }

  // Countdown timer function to update the UI every second
  void _startCountdown() {
    setState(() {
      _countdown = 3;  // Reset countdown to 3
    });

    // Create a periodic timer that updates the countdown every second
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 1) {
          _countdown -= 1;  // Decrease countdown value by 1 each second
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Demo'),  // Title displayed in the app bar
      ),
      // The body of the app containing a countdown and a button
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the countdown value on the screen
            Text(
              'Countdown: $_countdown',  // Countdown text
              style: TextStyle(fontSize: 24),  // Font size for countdown text
            ),
            SizedBox(height: 20),  // Add some space between the text and button
            // Button to start the countdown and show the notification
            ElevatedButton(
              onPressed: showNotificationWithCountdown,  // Call the method when pressed
              child: Text('Show Notification After 3 Seconds'),  // Button label
            ),
          ],
        ),
      ),
    );
  }
}
