import 'package:flutter/material.dart';

// The main function which runs the app
void main() {
  runApp(MyApp());
}

// The root widget of the app
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(), // Sets the home screen of the app
      debugShowCheckedModeBanner: false,
    );
  }
}

// The home screen where the button to show the custom dialog is located
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _selected; // Holds "Yes", "No", or "Maybe"

  Future<void> _openDialog() async {
    final result = await showDialog(
      context: context,
      barrierDismissible: true, // tapping outside returns null
      builder: (BuildContext context) {
        return CustomDialog(); // Returning the custom dialog
      },
    );

    if (result != null) {
      setState(() => _selected = result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Dialog Example'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Button that will trigger the custom dialog
            ElevatedButton(
              onPressed: _openDialog,
              child: Text('Show Custom Dialog'),
            ),
            const SizedBox(height: 24),
            // Shows current selection on the UI
            Text(
              _selected == null ? 'No selection yet.' : 'Selected: $_selected',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            if (_selected != null)
              Chip(
                label: Text(_selected!),
                avatar: const Icon(Icons.check_circle_outline),
              ),
          ],
        ),
      ),
    );
  }
}

// A custom dialog class that extends StatelessWidget to define the structure of the dialog
class CustomDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      // Defining the shape of the dialog, using a rounded rectangle
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 0.0,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          color: Colors.white, // Setting the dialog's background color
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Makes the dialog adapt to its content size
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Make a Choice',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            const Text(
              'Please select one of the options below:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            // Three buttons row: No / Maybe / Yes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () => Navigator.pop(context, 'No'),
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Maybe'),
                  child: const Text('Maybe'),
                ),
                FilledButton(
                  onPressed: () => Navigator.pop(context, 'Yes'),
                  child: const Text('Yes'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Optional close button that does not return a value
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton.icon(
                onPressed: () => Navigator.pop(context), // Close without selection (null)
                icon: const Icon(Icons.close),
                label: const Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
