import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp()); // Entry point of the app
}

// Root widget – Stateless because it just sets up MaterialApp
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyForm(), // Loads the form screen
    );
  }
}

// Stateful widget – form values will change dynamically
class MyForm extends StatefulWidget {
  const MyForm({super.key});
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
  final _confirmController = TextEditingController();
  final _emailController = TextEditingController();

  // Variables to display submitted results
  String _username = '';
  String _email = '';

  // Gate submit
  bool _agreed = false;

  // Email regex (improved)
  final _emailRe = RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[A-Za-z]{2,}$');

  // Live validation behavior
  AutovalidateMode _mode = AutovalidateMode.disabled;

  // --- Submit handler ---
  void _trySubmit() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _username = _usernameController.text.trim();
        _email = _emailController.text.trim();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Welcome, $_username ($_email)'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      // Optionally clear after submit:
      // _clear();
    }
  }

  void _clear() {
    _formKey.currentState?.reset();
    _usernameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _confirmController.clear();
    setState(() {
      _agreed = false;
      _username = '';
      _email = '';
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  // Helper to decide if submit should be enabled
  bool get _canSubmit {
    final validNow = _formKey.currentState?.validate() ?? false;
    return _agreed && validNow;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Form Activity'),
        actions: [
          // Toggle autovalidation quickly during demo
          TextButton(
            onPressed: () {
              setState(() {
                _mode = (_mode == AutovalidateMode.disabled)
                    ? AutovalidateMode.onUserInteraction
                    : AutovalidateMode.disabled;
              });
            },
            child: Text(
              _mode == AutovalidateMode.disabled ? 'Auto-validate: OFF' : 'Auto-validate: ON',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),

        // Wrap inputs inside a Form widget for validation
        child: Form(
          key: _formKey,
          autovalidateMode: _mode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // full width
            children: <Widget>[
              // ===============================
              // USERNAME FIELD
              // ===============================
              TextFormField(
                controller: _usernameController, // links to controller
                decoration: const InputDecoration(labelText: 'Username'),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a username';
                  }
                  if (value.trim().length < 3) {
                    return 'Username must be at least 3 characters';
                  }
                  return null; // valid input
                },
              ),

              const SizedBox(height: 12),

              // ===============================
              // EMAIL FIELD
              // ===============================
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'example@domain.com', // helpful hint text
                ),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter an email';
                  }
                  if (!_emailRe.hasMatch(value.trim())) {
                    return 'Please enter a valid email';
                  }
                  return null; // valid input
                },
              ),

              const SizedBox(height: 12),

              // ===============================
              // PASSWORD FIELD
              // ===============================
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true, // hides password characters
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  } else if (value.length < 8) {
                    return 'Password must be at least 8 characters';
                  } else if (!RegExp(r'.*\d').hasMatch(value)) {
                    return 'Include at least one number';
                  }
                  return null; // valid input
                },
              ),

              const SizedBox(height: 12),

              // ===============================
              // CONFIRM PASSWORD FIELD
              // ===============================
              TextFormField(
                controller: _confirmController,
                decoration: const InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please re-enter your password';
                  }
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 8),

              // ===============================
              // TERMS CHECKBOX (gates submit)
              // ===============================
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                title: const Text('I agree to the Terms & Conditions'),
                value: _agreed,
                onChanged: (v) => setState(() => _agreed = v ?? false),
              ),

              const SizedBox(height: 16.0),

              // ===============================
              // SUBMIT & CLEAR
              // ===============================
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _clear,
                      child: const Text('Clear'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _canSubmit ? _trySubmit : null,
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20.0),

              // ===============================
              // DISPLAY ENTERED DATA (after submit)
              // ===============================
              Text('Username: ${_username.isEmpty ? '—' : _username}'),
              Text('Email: ${_email.isEmpty ? '—' : _email}'),
            ],
          ),
        ),
      ),
    );
  }
}
