import 'package:flutter/material.dart';

// DisplayPage is a StatelessWidget that shows the username and email passed from another screen.
class DisplayPage extends StatelessWidget {
  final String username;  // Holds the username to display
  final String email;     // Holds the email to display

  // Constructor to initialize username and email when DisplayPage is created.
  DisplayPage({required this.username, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold provides the basic structure for the screen
      appBar: AppBar(
        // AppBar at the top with the title 'Display Page'
        title: Text('Display Page'),
      ),
      // Body of the page is centered using Center widget
      body: Center(
        // Column widget to organize the display of username and email vertically
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center the content vertically in the middle of the screen
          children: <Widget>[
            // Text widget to display the label 'Username'
            Text(
              'Username:',
              style: TextStyle(
                fontSize: 24,              // Font size for the label
                fontWeight: FontWeight.bold, // Bold font for emphasis
                color: Colors.green,        // Green color for the text
              ),
            ),
            // Text widget to display the actual username value
            Text(
              username,                    // Displays the username passed in from the constructor
              style: TextStyle(
                fontSize: 36,              // Larger font for the username
                fontWeight: FontWeight.bold, // Bold font for emphasis
                color: Colors.green,        // Same green color for consistency
              ),
            ),
            SizedBox(height: 20),           // Adds some vertical space between username and email
            // Text widget to display the label 'Email'
            Text(
              'Email:',
              style: TextStyle(
                fontSize: 24,              // Font size for the label
                fontWeight: FontWeight.bold, // Bold font for emphasis
                color: Colors.green,        // Green color for the text
              ),
            ),
            // Text widget to display the actual email value
            Text(
              email,                       // Displays the email passed in from the constructor
              style: TextStyle(
                fontSize: 36,              // Larger font for the email
                fontWeight: FontWeight.bold, // Bold font for emphasis
                color: Colors.green,        // Same green color for consistency
              ),
            ),
          ],
        ),
      ),
    );
  }
}
