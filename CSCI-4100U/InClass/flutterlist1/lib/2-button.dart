import 'package:flutter/material.dart'; // Import the Flutter Material Design library

// ----------------------
// Entry point of the app
// ----------------------
void main() {
  runApp(MyApp()); // Launch the Flutter application by running MyApp widget
}

// ----------------------
// Root widget of the app
// ----------------------
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text Update Example', // App title (appears in app switcher)
      home: TextUpdateApp(),         // Set the home screen widget
    );
  }
}

// ----------------------------------------------------
// A StatefulWidget because the displayed text changes
// ----------------------------------------------------
class TextUpdateApp extends StatefulWidget {
  @override
  _TextUpdateAppState createState() => _TextUpdateAppState();
}

// ---------------------------------------------
// The state object holds mutable (changing) data
// ---------------------------------------------
class _TextUpdateAppState extends State<TextUpdateApp> {
  String labelText = '';   // Text displayed inside the green box
  String currentText = ''; // Temporarily holds user input from TextField

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Update Example'), // Top app bar title
      ),
      body: Center(
        // Center the entire column vertically and horizontally
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Vertically center elements
          children: <Widget>[
            // =======================================
            // Display box showing submitted text
            // =======================================
            Container(
              width: 200.0, // Fixed width
              height: 200.0, // Fixed height
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.green, // Green border color
                  width: 2.0,          // Border thickness
                ),
              ),
              child: Center(
                // Center the text inside the box
                child: Text(
                  labelText, // Text shown inside the container
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),

            // =======================================
            // Text input field
            // =======================================
            TextFormField(
              style: TextStyle(fontSize: 24), // Make the text input larger
              onChanged: (text) {
                // Triggered every time the user types
                currentText = text; // Store user input temporarily
                // No setState here — we don’t need to update UI until submit
              },
              decoration: InputDecoration(
                labelText: 'Enter Text',           // Field label
                labelStyle: TextStyle(fontSize: 24), // Label font size
              ),
            ),

            // Add spacing between the text field and button
            SizedBox(height: 20.0),

            // =======================================
            // Button to update the displayed text
            // =======================================
            ElevatedButton(
              onPressed: () {
                // When the button is pressed:
                setState(() {
                  // setState tells Flutter to rebuild the widget tree
                  labelText = currentText; // Update box text with current input
                });
              },
              child: Text('Submit'), // Button label
            ),
          ],
        ),
      ),
    );
  }
}
