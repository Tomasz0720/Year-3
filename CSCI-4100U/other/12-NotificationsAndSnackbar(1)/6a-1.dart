// Import the Flutter Material package — gives access to all Material Design widgets
import 'package:flutter/material.dart';

// The main() function — this is where the app starts running
void main() {
  // runApp() inflates the given widget (MyApp) and attaches it to the screen
  runApp(MyApp());
}

// MyApp is the root widget of the app. It defines the app’s overall structure and theme.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // MaterialApp sets up important app-level configuration
    // such as routes, navigation, and design style (Material Design)
    return MaterialApp(
      // The first page to show when the app launches
      home: HomeScreen(),
    );
  }
}

// HomeScreen is a simple page (screen) that contains our main UI
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Scaffold provides the basic visual layout structure:
    // an AppBar at the top, body in the middle, etc.
    return Scaffold(
      // Top bar of the app showing the title
      appBar: AppBar(
        title: Text('Snackbar Example'),
      ),

      // The main content of the screen
      body: Center(
        // A button centered in the middle of the screen
        child: ElevatedButton(
          // What happens when the button is pressed
          onPressed: () {
            // Step 1: Create a SnackBar widget with text and an optional action button
            final snackbar = SnackBar(
              content: Text('Event Deleted'), // The message shown in the Snackbar

              // The action button that appears on the right side of the Snackbar
              action: SnackBarAction(
                label: 'Undo', // The text for the action button
                onPressed: () {
                  // Code inside here runs when the user taps 'Undo'
                  print('Undo action');
                },
              ),
            );

            // Step 2: Use ScaffoldMessenger to show the Snackbar in the current context
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
          },

          // Text displayed on the button itself
          child: Text('Show Snackbar'),
        ),
      ),
    );
  }
}
