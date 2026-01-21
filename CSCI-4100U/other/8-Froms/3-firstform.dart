import 'package:flutter/material.dart'; // Import Flutter’s material design package

// ----------------------
// Entry point of the app
// ----------------------
void main() {
  runApp(MyApp()); // Launch the application by running MyApp
}

// ----------------------
// Root widget (Stateless)
// ----------------------
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Form Example', // App title (for the OS/task manager)
      home: SimpleFormApp(),         // The home screen of the app
    );
  }
}

// ----------------------------------------------------
// StatefulWidget — needed because form input changes
// ----------------------------------------------------
class SimpleFormApp extends StatefulWidget {
  @override
  _SimpleFormAppState createState() => _SimpleFormAppState();
}

// ----------------------------------------------------
// State class — holds form data and manages UI changes
// ----------------------------------------------------
class _SimpleFormAppState extends State<SimpleFormApp> {
  // A GlobalKey uniquely identifies the Form widget and allows validation/saving
  final _formKey = GlobalKey<FormState>();

  // Variables to store user input
  String username = '';
  String password = '';

  // Tracks if the form has been submitted (for conditional rendering)
  bool formSubmitted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Form Example'),
      ),

      // Padding adds space inside the screen around the Form
      body: Padding(
        padding: const EdgeInsets.all(20.0),

        // ------------------------
        // The actual form widget
        // ------------------------
        child: Form(
          key: _formKey, // Connects this Form to the global key

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch children horizontally
            children: <Widget>[
              // =======================
              // USERNAME TEXT FIELD
              // =======================
              TextFormField(
                decoration: InputDecoration(labelText: 'Username'),
                onChanged: (value) {
                  // Update username whenever user types
                  setState(() {
                    username = value;
                  });
                },
                // Disable the username field once the form is submitted
                enabled: !formSubmitted,
              ),

              // =======================
              // PASSWORD TEXT FIELD
              // =======================
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true, // Hide the password text for privacy (dots instead of letters)
                onChanged: (value) {
                  // Update password value on each keystroke
                  setState(() {
                    password = value;
                  });
                },
              ),

              SizedBox(height: 20.0), // Add spacing before the button

              // =======================
              // SUBMIT BUTTON
              // =======================
              ElevatedButton(
                onPressed: () {
                  // When pressed:
                  setState(() {
                    // Mark form as submitted
                    formSubmitted = true;
                  });

                  // Save the form state (if needed for validation or backend)
                  _formKey.currentState!.save();
                },
                child: Text('Submit'),
              ),

              SizedBox(height: 20.0), // Add spacing before showing results

              // =======================
              // CONDITIONAL RESULT BOX
              // =======================
              if (formSubmitted)
                Container(
                  decoration: BoxDecoration(
                    border:
                    Border.all(color: Colors.green, width: 2.0), // Add border
                  ),
                  padding: EdgeInsets.all(10.0), // Add inner spacing
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Display user input
                      Text('Username: $username'),
                      Text('Password: $password'),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
