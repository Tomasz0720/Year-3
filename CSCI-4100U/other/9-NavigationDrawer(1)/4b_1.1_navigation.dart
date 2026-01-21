import 'package:flutter/material.dart';

// The entry point of the Flutter app
void main() {
  runApp(MyApp());  // Runs the MyApp widget as the root of the app
}

// StatelessWidget for the overall app structure
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // The home widget of the app, which is a stateful widget called MyHomePage
      home: MyHomePage(),
    );
  }
}

// A stateful widget that manages dynamic state changes
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();  // Creates the mutable state for this widget
}

// The mutable state of MyHomePage
class _MyHomePageState extends State<MyHomePage> {
  // Variables to hold the username and email passed from the FormPage
  String? _displayedUsername;
  String? _displayedEmail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar provides the title at the top of the screen
      appBar: AppBar(
        title: Text('Flutter Form App'), // Title displayed in the AppBar
      ),
      // The body of the screen, centered content
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // Center the children vertically
          children: <Widget>[
            // Display username and email if both are not null
            if (_displayedUsername != null && _displayedEmail != null)
              Text('Username: $_displayedUsername\nEmail: $_displayedEmail'),
          ],
        ),
      ),
      // Floating Action Button (FAB) to open the FormPage when pressed
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // Navigate to FormPage and wait for the result (username and email)
            final result = await Navigator.push(context,
              MaterialPageRoute(
                builder: (context) => FormPage(), // Navigates to the FormPage when pressed
              ),
            );

            // If a valid result (Map with data) is returned, update the UI with the result
            if (result != null && result is Map) { //? map
              setState(() {
                _displayedUsername = result['username']; // Store the username
                _displayedEmail = result['email']; // Store the email
              });
            }
          }),
    );
  }
}

// StatelessWidget to represent the form for username and email input
class FormPage extends StatelessWidget {
  // Controllers for the text fields to capture user input
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar with the title for the FormPage
      appBar: AppBar(
        title: Text('User Information'),  // Title displayed in the AppBar
      ),
      // Padding around the form content
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        // Column layout to display text fields and the submit button
        child: Column(
          children: <Widget>[
            // Text field for username input
            TextField(
              controller: _usernameController,  // Binds the controller to capture username input
              decoration: InputDecoration(labelText: 'Username'),  // Label for the input field
            ),
            // Text field for email input
            TextField(
              controller: _emailController,  // Binds the controller to capture email input
              decoration: InputDecoration(labelText: 'Email'),  // Label for the input field
            ),
            SizedBox(height: 20),  // Adds vertical space between the fields and the button
            // Submit button
            ElevatedButton(
              onPressed: () {
                // Captures the input text from the controllers
                final userN = _usernameController.text; //?
                final emA = _emailController.text; //?

                // If both fields are not empty, pass the data back to the previous screen
                if (userN.isNotEmpty && emA.isNotEmpty) {
                  Navigator.pop(context, {
                    'username': userN,  // Send the username back
                    'email': emA, // Send the email back
                  });
                }
              },
              child: Text('Submit'),  // Text on the button
            ),
          ],
        ),
      ),
    );
  }
}
