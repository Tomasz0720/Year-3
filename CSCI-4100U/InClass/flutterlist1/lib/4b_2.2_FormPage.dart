import 'package:flutter/material.dart';

// FormPage is a StatelessWidget that contains input fields to capture user information (username and email).
class FormPage extends StatelessWidget {
  // Controllers to capture the input from the text fields
  final TextEditingController _usernameController = TextEditingController();  // Captures the username input
  final TextEditingController _emailController = TextEditingController();     // Captures the email input

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold provides the overall structure for the screen with an AppBar and body
      appBar: AppBar(
        title: Text('User Information'),  // The title shown in the app's top bar
      ),
      // Padding widget adds space around the child widgets for better layout
      body: Padding(
        padding: const EdgeInsets.all(20.0),  // 20 pixels of padding on all sides
        // Column widget lays out its children in a vertical direction
        child: Column(
          children: <Widget>[
            // TextField to input the username
            TextField(
              controller: _usernameController,  // Links this field to the username controller
              decoration: InputDecoration(
                labelText: 'Username',  // Adds a label inside the input field
              ),
            ),
            // TextField to input the email
            TextField(
              controller: _emailController,  // Links this field to the email controller
              decoration: InputDecoration(
                labelText: 'Email',  // Adds a label inside the input field
              ),
            ),
            // SizedBox adds space between the text fields and the button
            SizedBox(height: 20),  // Adds 20 pixels of vertical space
            // ElevatedButton to submit the form
            ElevatedButton(
              onPressed: () {
                // Captures the text entered by the user in both fields
                final username = _usernameController.text;
                final email = _emailController.text;

                // Checks if both fields are not empty before submitting
                if (username.isNotEmpty && email.isNotEmpty) {
                  // Passes the captured data back to the previous screen and pops (closes) this screen
                  Navigator.pop(context, {
                    'username': username,  // Sends the username back
                    'email': email,        // Sends the email back
                  });
                }
              },
              child: Text('Submit'),  // The label of the button
            ),
          ],
        ),
      ),
    );
  }
}
