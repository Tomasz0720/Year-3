import 'package:flutter/material.dart';

// The main function is the entry point of the app
void main() {
  runApp(MyApp()); // Runs the MyApp widget as the root of the app
}

// MyApp is a StatelessWidget that builds the main structure of the app
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // MaterialApp provides the app's basic configuration, such as routes and themes
    return MaterialApp(
      title: 'Simple AlertDialog',  // Title of the app
      home: MyHomePage(),  // The home screen of the app, which displays MyHomePage
    );
  }
}

// MyHomePage is a StatelessWidget that displays the home screen with a button to trigger the AlertDialog
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Scaffold provides the structure with an AppBar, body, etc.
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple AlertDialog Demo'),  // The title of the screen displayed in the app bar
      ),
      body: Center(
        // ElevatedButton is a button that, when pressed, triggers an action
        child: ElevatedButton(
          onPressed: () {
            // This function is called when the button is pressed and it shows the AlertDialog
            showDialog(
              context: context,  // Context refers to the current widget's location in the widget tree
              builder: (context) {
                // Building the AlertDialog widget
                return AlertDialog(
                  title: Text('Important Info'),  // Title displayed in the dialog
                  content: Text('This is a simple alert dialog.'),  // The message/content of the dialog
                  actions: <Widget>[
                    // TextButton is a button inside the dialog that allows the user to perform an action
                    TextButton(
                      child: Text('Close'),  // Label of the button
                      onPressed: () {
                        // Close the dialog when the button is pressed
                        Navigator.pop(context);  // Pop removes the dialog from the navigation stack
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: Text('Show Alert Dialog'),  // The label of the ElevatedButton
        ),
      ),
    );
  }
}
