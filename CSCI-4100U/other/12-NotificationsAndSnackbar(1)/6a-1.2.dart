// Import Flutter's Material package (provides UI widgets following Material Design)
import 'package:flutter/material.dart';

// The main entry point of the application
void main() {
  runApp(MyApp());
}

// Root widget for the whole app
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Advanced Snackbar Example',
      debugShowCheckedModeBanner: false, // Hide the debug banner
      home: HomeScreen(), // Set the main page
    );
  }
}

// A StatefulWidget because we will interact with user input
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Controller to read text entered by the user
  final TextEditingController _controller = TextEditingController();

  // Function to show a snackbar with dynamic message and optional action
  void _showCustomSnackbar(String message, {bool withUndo = false}) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3), // Auto-dismiss after 3 seconds
      backgroundColor: Colors.blueGrey.shade700,
      action: withUndo
          ? SnackBarAction(
        label: 'Undo',
        textColor: Colors.yellowAccent,
        onPressed: () {
          // What happens when "Undo" is pressed
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Undo successful!')),
          );
        },
      )
          : null,
    );

    // Display the SnackBar
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Advanced Snackbar Example'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // Column arranges widgets vertically
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // A text field to enter some input
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter a message',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            // Row of buttons for different actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // ✅ Show message directly from the text field
                ElevatedButton(
                  onPressed: () {
                    String msg = _controller.text.trim();
                    if (msg.isEmpty) {
                      _showCustomSnackbar('Please type something first!');
                    } else {
                      _showCustomSnackbar('Message sent: "$msg"');
                      _controller.clear(); // Clear input after sending
                    }
                  },
                  child: Text('Send'),
                ),

                // ❌ Simulate deleting something (e.g., an event)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    _showCustomSnackbar('Event deleted', withUndo: true);
                  },
                  child: Text('Delete'),
                ),
              ],
            ),

            SizedBox(height: 20),

            // A long-running operation example (loading feedback)
            ElevatedButton.icon(
              onPressed: () {
                _showCustomSnackbar('Uploading file...');
                // Simulate some process delay using Future.delayed
                Future.delayed(Duration(seconds: 2), () {
                  _showCustomSnackbar('Upload complete!', withUndo: false);
                });
              },
              icon: Icon(Icons.cloud_upload),
              label: Text('Simulate Upload'),
            ),
          ],
        ),
      ),
    );
  }

  // Always dispose controllers in stateful widgets to free memory
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
