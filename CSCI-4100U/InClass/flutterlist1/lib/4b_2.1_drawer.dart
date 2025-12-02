import 'package:flutter/material.dart';
import '4b_2.2_FormPage.dart';   // Importing the form page where users enter their details
import '4b_2.3_AppDrawer.dart'; // Importing a custom navigation drawer
import '4b_2.4_display_page.dart';  // Importing the display page for showing user information

// The main entry point of the application
void main() {
  runApp(MyApp());  // Runs the MyApp widget as the root of the app
}

// MyApp is a StatelessWidget representing the top-level widget of the app
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // MaterialApp sets up the basic app structure and routing
    return MaterialApp(
      home: MyHomePage(), // The first screen of the app (home)
    );
  }
}

// MyHomePage is a StatefulWidget that holds the dynamic state of the app (username and email)
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();  // Creates the mutable state for this widget
}

// The mutable state for MyHomePage
class _MyHomePageState extends State<MyHomePage> {
  // Variables to hold the username and email to display on the main screen
  String? _displayedUsername;
  String? _displayedEmail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold provides the structure of the page, with an AppBar, body, and drawer
      appBar: AppBar(
        title: Text(
            'Flutter Form App'), // The title displayed at the top of the screen
      ),
      // Drawer that slides in from the side of the screen, with navigation options
      drawer: AppDrawer(
          onTapMyVersion: (page) {
        Navigator.pop(context); // Close the drawer after selecting an option

        // Check which page the user selected in the drawer
        if (page == 'Form Page') { //?
          _openFormPage(); // Open the form page to collect user details
        } else if (page == 'Display Page') { //?
          // Open the display page to show username and email if available
          _openDisplayPage(_displayedUsername!, _displayedEmail!);
        }
      }),
      // The main body of the page, centered content
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // Center the content vertically
          children: <Widget>[
            // If username and email are not null, display them in the UI
            if (_displayedUsername != null && _displayedEmail != null)
              Text('Username: $_displayedUsername\nEmail: $_displayedEmail'),
            // Shows the user information
          ],
        ),
      ),
      // Floating action button to open the form page when pressed
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // Navigate to the FormPage and wait for the result (username and email)
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FormPage(), // Navigate to the FormPage
              ),
            );

            // Check if the result is not null and contains valid data
            if (result != null && result is Map) {
              setState(() {
                // Update the displayed username and email with the result
                _displayedUsername = result['username'];
                _displayedEmail = result['email'];
              });
            }
          }),
    );
  }

  // Function to open the FormPage to collect user details
  void _openFormPage() async {
    // Navigate to the FormPage and wait for the result
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormPage(), // Navigate to the FormPage
      ),
    );

    // Check if the result is valid and update the state with the username and email
    if (result != null && result is Map) {
      setState(() {
        _displayedUsername = result['username']; // Update the username
        _displayedEmail = result['email']; // Update the email
      });
    }
  }

  // Function to open the DisplayPage, passing the username and email
  void _openDisplayPage(String username, String email) {
    Navigator.push(
      context,
      MaterialPageRoute(
        // Navigate to the DisplayPage and pass the username and email as arguments
        builder: (context) => DisplayPage(username: username, email: email),
      ),
    );
  }
}
