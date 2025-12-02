import 'package:flutter/material.dart';

void main() {
  runApp(MyApp()); // Entry point of the app
}

// Root widget – Stateless because it just sets up MaterialApp
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyForm(), // Loads the form screen
    );
  }
}

// Stateful widget – form values will change dynamically
class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

// The State class – holds form state, controllers, and data variables
class _MyFormState extends State<MyForm> {
  // GlobalKey allows access to the Form widget for validation
  final _formKey = GlobalKey<FormState>();

  // Controllers manage the text entered into each field
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  // Variables to display submitted results
  String _username = '';
  String _password = '';
  String _email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Form App'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),

        // Wrap inputs inside a Form widget for validation
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // full width
            children: <Widget>[
              // ===============================
              // USERNAME FIELD
              // ===============================
              TextFormField(
                controller: _usernameController, // links to controller
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  // Field validation logic
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null; // valid input
                },
              ),

              // ===============================
              // PASSWORD FIELD
              // ===============================
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true, // hides password characters
                validator: (value) {
                  // Password validation logic
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  } else if (value.length < 8) {
                    return 'Password must be at least 8 characters';
                  }
                  return null; // valid input
                },
              ),

              // ===============================
              // EMAIL FIELD
              // ===============================
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'example@domain.com', // helpful hint text
                ),
                validator: (value) {
                  // Email validation with regex
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                      .hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null; // valid input
                },
              ),

              SizedBox(height: 20.0),

              // ===============================
              // SUBMIT BUTTON
              // ===============================
              ElevatedButton(
                onPressed: () {
                  // Validate all form fields before proceeding
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      // Store form data in variables
                      _username = _usernameController.text;
                      _password = _passwordController.text;
                      _email = _emailController.text;
                    });
                  }
                },
                child: Text('Submit'),
              ),

              SizedBox(height: 20.0),

              // ===============================
              // DISPLAY ENTERED DATA
              // ===============================
              Text('Username: $_username'),
              Text('Password: $_password'),
              Text('Email: $_email'),
            ],
          ),
        ),
      ),
    );
  }
}
