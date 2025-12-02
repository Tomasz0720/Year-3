import 'package:flutter/material.dart';

void main() {
  runApp(MyApp()); // Entry point of the app
}

// Root widget – Stateless because it just sets up MaterialApp
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InfoForm(), // Loads the form screen
    );
  }
}

// Stateful widget – form values will change dynamically
class InfoForm extends StatefulWidget {
  @override
  _InfoFormState createState() => _InfoFormState();
}

// The State class – holds form state, controllers, and data variables
class _InfoFormState extends State<InfoForm> {
  // GlobalKey allows access to the Form widget for validation
  final _formGate = GlobalKey<FormState>();

  // Controllers manage the text entered into each field
  // [A] TODO: Create controllers (name, family, age) - Text Editing Controller
  final _nameCtrl = TextEditingController();
  final _familyCtrl = TextEditingController();
  final _ageCtrl = TextEditingController();

  // Variables to display submitted results
  String _name = '';
  String _family = '';
  String _age = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Basic Info Form'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),

        // [B] TODO: Wrap inputs inside a Form widget for validation
        child: Form(
          // [C] TODO: Key Value?
          key: _formGate,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // full width
            children: <Widget>[
              // ===============================
              // NAME FIELD
              // ===============================
              //[D] TODO: use TextFormField
              TextFormField(
                controller: _nameCtrl, // [E] TODO: link controller properly
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  // [F] TODO: Implement name validation (non-empty) - if empty :
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),

              // ===============================
              // FAMILY NAME FIELD
              // ===============================
               // [G] TODO:
              TextFormField(
                controller: _familyCtrl, // [H] TODO:
                decoration: InputDecoration(labelText: 'Family Name'),
                validator: (value) {
                  // [I] TODO:
                  if (value == null || value.isEmpty) {
                    return 'Please enter your family name';
                  }
                  return null;
                },
              ),

              // ===============================
              // AGE FIELD
              // ===============================
              TextFormField(
                controller: _ageCtrl,
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your age';
                  } else if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20.0),

              // ===============================
              // SUBMIT BUTTON
              // ===============================
              // [j] TODO: elevated button
              ElevatedButton(
                onPressed: () {
                  //// [k] TODO: call form validation
                  if (_formGate.currentState!.validate()) {
                    // [l] TODO: update UI
                    setState(() {
                      //  [m] TODO: Save form data from controllers
                      _name = _nameCtrl.text;
                      _family = _familyCtrl.text;
                      _age = _ageCtrl.text;
                    });
                  }
                },
                child: Text('Submit'),
              ),

              SizedBox(height: 20.0),

              // ===============================
              // DISPLAY ENTERED DATA
              // ===============================
              Text('Name: $_name'),
              Text('Family Name: $_family'),
              Text('Age: $_age'),
            ],
          ),
        ),
      ),
    );
  }
}