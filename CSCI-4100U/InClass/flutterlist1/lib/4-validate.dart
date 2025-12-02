import 'package:flutter/material.dart';

void main() {
  runApp(MyApp()); // App entry point: inflate and run the root widget
}

// Root widget: Stateless because it only sets up MaterialApp and a home screen.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Password Check Example',
      home: PasswordCheckApp(), // Navigate directly to the form screen.
    );
  }
}

// We need a StatefulWidget because form input and UI flags will change over time.
class PasswordCheckApp extends StatefulWidget {
  @override
  _PasswordCheckAppState createState() => _PasswordCheckAppState();
}

// The State object holds mutable data (form fields, flags) and rebuilds the UI via setState().
class _PasswordCheckAppState extends State<PasswordCheckApp> {
  // A GlobalKey lets us access the Form state (e.g., to validate or save).
  final _formKey = GlobalKey<FormState>();

  // Backing variables for user input. (In production, consider controllers if you need more control.)
  String username = '';
  String password = '';

  // Controls whether we render the summary box with entered credentials.
  bool showCredentials = false;

  // -------------------------
  // Field validators
  // Return a String error message to show an error, or null if valid.
  // -------------------------
  String? validateUserName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    return null; // null => valid
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null; // valid
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Password Check Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),

        // Form groups fields and integrates validation with the provided _formKey.
        child: Form(
          key: _formKey,

          // Lay out form fields and actions vertically.
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // Make children full width.
            children: <Widget>[
              // --------------------
              // USERNAME FIELD
              // --------------------
              TextFormField(
                decoration: InputDecoration(labelText: 'Username'),
                // Keep local state in sync as the user types.
                onChanged: (value) {
                  setState(() {
                    username = value;
                  });
                },
                validator: validateUserName, // Attach validator for this field.
              ),

              // --------------------
              // PASSWORD FIELD
              // --------------------
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true, // Mask input for privacy.
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
                validator: validatePassword, // Attach validator for this field.
              ),

              SizedBox(height: 20.0),

              // --------------------
              // SUBMIT BUTTON
              // --------------------
              ElevatedButton(
                onPressed: () {
                  // Validate all fields in the Form. Each field's validator runs.
                  final isValid = _formKey.currentState!.validate();

                  if (isValid) {
                    // Optionally call save() if using onSaved handlers.
                    _formKey.currentState!.save();

                    // If valid, show the summary box.
                    setState(() {
                      showCredentials = true;
                    });
                  } else {
                    // If invalid, hide the summary box for consistent UX.
                    setState(() {
                      showCredentials = false;
                    });
                  }
                },
                child: Text('Submit'),
              ),

              SizedBox(height: 20.0),

              // --------------------------------------------
              // CONDITIONAL SUMMARY
              // Only renders when form is valid & submitted.
              // --------------------------------------------
              if (showCredentials)
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green, width: 2.0),
                  ),
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Teaching note: Never display raw passwords in real apps.
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
