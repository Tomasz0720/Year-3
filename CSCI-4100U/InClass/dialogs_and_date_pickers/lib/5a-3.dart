import 'package:flutter/material.dart';

// Main function to run the app
void main() {
  runApp(MyApp()); // Runs the root widget of the app
}

// The MyApp class is the root widget of the app
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SimpleDialog Example',
      home: MyHomePage(), // Home page of the app
    );
  }
}

// MyHomePage is a stateless widget that shows a button to open the SimpleDialog
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SimpleDialog Example'), // The title on the app bar
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Call to a function that opens the dialog when the button is pressed
            var result = showDealDialog(context);
          },
          child: Text('Show SimpleDialog'), // Button text
        ),
      ),
    );
  }

  // Function to show the SimpleDialog
  // This function does not use Future and directly shows the dialog.
  void showDealDialog(BuildContext context) {
    // showDialog function is used to display a dialog box
    showDialog(
      context: context, // The build context of the widget
      builder: (context) {
        // Builder defines the structure of the dialog box
        return SimpleDialog(
          title: Text('Want me to find you a deal?'), // Dialog title
          children: <Widget>[
            // Two options for the user to select: Yes or No
            SimpleDialogOption(
              child: const Text('Yes'), // Option 1: Yes
              onPressed: () {
                // If 'Yes' is pressed, close the dialog and return true
                Navigator.pop(context, true); // Closes the dialog and returns true
              },
            ),
            SimpleDialogOption(
              child: const Text('No'), // Option 2: No
              onPressed: () {
                // If 'No' is pressed, close the dialog and return false
                Navigator.pop(context, false); // Closes the dialog and returns false
              },
            ),
          ],
        );
      },
    );
  }
}
