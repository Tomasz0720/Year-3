import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DateTimePickerExample(),
    );
  }
}

class DateTimePickerExample extends StatefulWidget {
  @override
  State<DateTimePickerExample> createState() => _DateTimePickerExampleState();
}

class _DateTimePickerExampleState extends State<DateTimePickerExample> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  void _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      setState(() => _selectedDate = date);
    }
  }

  void _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null) {
      setState(() => _selectedTime = time);
    }
  }

  // Combine date + time into one readable string
  String get _formattedDateTime {
    if (_selectedDate == null && _selectedTime == null) return 'No selection yet';
    if (_selectedDate != null && _selectedTime == null) {
      return 'Date: ${_formatDate(_selectedDate!)}';
    }
    if (_selectedDate == null && _selectedTime != null) {
      return 'Time: ${_formatTime(_selectedTime!)}';
    }

    final date = _formatDate(_selectedDate!);
    final time = _formatTime(_selectedTime!);
    return 'Date: $date  •  Time: $time';
  }

  // Manual formatting without intl
  String _formatDate(DateTime date) =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Date & Time Picker')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_formattedDateTime, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _pickDate,
              child: const Text('Pick Date'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _pickTime,
              child: const Text('Pick Time'),
            ),
          ],
        ),
      ),
    );
  }
}
