import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TimePickerExample(),
    );
  }
}

class TimePickerExample extends StatefulWidget {
  @override
  _TimePickerExampleState createState() => _TimePickerExampleState();
}

class _TimePickerExampleState extends State<TimePickerExample> {
  // Declare a variable to hold the selected time
  TimeOfDay _selectedTime = TimeOfDay.now();

  // Function to open the time picker dialog and handle the selected time
  void _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime, // Set the initial time to the current selected time
    );

    // If the user picks a time (not null), update the state with the new time
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Picker Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Display the selected time in a Text widget
            Text(
              'Selected time: ${_selectedTime.format(context)}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            // Button to open the time picker
            ElevatedButton(
              onPressed: () {
                _selectTime(); // Call the function to select a time
              },
              child: Text('Select Time'),
            ),
          ],
        ),
      ),
    );
  }
}
