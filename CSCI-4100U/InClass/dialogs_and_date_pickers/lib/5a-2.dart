import 'package:flutter/material.dart';

// Main function - entry point of the application
void main() {
  runApp(MyApp()); // MyApp widget is run as the root of the app
}

// MyApp is a StatelessWidget that defines the structure of the app
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // MaterialApp provides the main structure of the app, including routing and themes
    return MaterialApp(
      title: 'AlertDialog Example', // The title of the app
      home: MyHomePage(), // The home screen of the app (MyHomePage)
    );
  }
}

// MyHomePage is a StatelessWidget that displays the main screen with a button to trigger the AlertDialog
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Scaffold provides the structure of the app, including the AppBar, body, etc.
    return Scaffold(
      appBar: AppBar(
        title: Text('AlertDialog Demo'),  // Title shown in the AppBar at the top
      ),
      // The body of the Scaffold contains a centered ElevatedButton
      body: Center(
        // ElevatedButton triggers the AlertDialog when pressed
        child: ElevatedButton(
          onPressed: () {
            // Call the separate function to show the AlertDialog when the button is pressed
            showMyAlertDialog(context); // Pass the context to the function
          },
          child: Text('Show Alert Dialog'), // Label for the button
        ),
      ),
    );
  }
}

// This function is defined outside the widget class and is responsible for creating and showing the AlertDialog
void showMyAlertDialog(BuildContext context) {
  // showDialog displays the dialog on the screen
  showDialog(
    context: context, // Context is required to know where to show the dialog
    builder: (context) {
      // AlertDialog is the popup box that appears on the screen
      return AlertDialog(
        title: Text('Important Info'), // Title of the AlertDialog
        content: Text('This is a simple alert dialog displayed from a function.'), // Message displayed in the dialog
        actions: <Widget>[
          // TextButton is a button displayed in the AlertDialog
          TextButton(
            child: Text('Close'), // Label for the button
            onPressed: () {
              // Closes the dialog when the button is pressed
              Navigator.pop(context); // Removes the dialog from the navigation stack
            },
          ),
        ],
      );
    },
  );
}
