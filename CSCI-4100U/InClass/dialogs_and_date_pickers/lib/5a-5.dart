import 'package:flutter/material.dart';

void main() => runApp(MyApp());

// The root of the application
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SimpleDatePicker(),  // Setting SimpleDatePicker as the home screen
    );
  }
}

// The main widget for showing the date picker example
class SimpleDatePicker extends StatefulWidget {
  @override
  _SimpleDatePickerState createState() => _SimpleDatePickerState();
}

class _SimpleDatePickerState extends State<SimpleDatePicker> {
  String? _selectedDate;  // Variable to hold the selected date

  // Method to show the date picker and update the selected date
  void _pickDate() async {
    // Show the date picker dialog and wait for the user's input
    DateTime? pickedDate = await showDatePicker(
      context: context,  // The build context
      initialDate: DateTime.now(),  // Initial date (today)
      firstDate: DateTime(2000),  // Earliest date that can be selected
      lastDate: DateTime(2100),   // Latest date that can be selected
    );

    // If the user selected a date (not null), update the state to reflect the new date
    if (pickedDate != null) {
      setState(() {
        //By default, showDatePicker gives you the date in UTC format (universal time).
        //.toLocal() converts it to your device’s local timezone.
        //"2025-10-21 11:30:00.000"
        _selectedDate = "${pickedDate.toLocal()}".split(' ')[0];  // Format the selected date
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Date Picker'),  // Title in the app bar
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,  // Center the content vertically
          children: <Widget>[
            // Display the selected date, or a placeholder if none selected
            Text(
              _selectedDate == null ? 'No date selected' : 'Selected Date: $_selectedDate',
              style: TextStyle(fontSize: 20),  // Larger font size for better readability
            ),
            SizedBox(height: 20),  // Add some space between the text and the button

            // Button to trigger the date picker
            ElevatedButton(
              onPressed: _pickDate,  // Call the method to show the date picker when pressed
              child: Text('Pick a Date'),
            ),
          ],
        ),
      ),
    );
  }
}
