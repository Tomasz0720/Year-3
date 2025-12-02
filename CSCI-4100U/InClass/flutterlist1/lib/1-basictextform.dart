import 'package:flutter/material.dart';

// Entry point of the Flutter application
void main() {
  runApp(MyApp()); // Runs the app by creating an instance of MyApp
}

// MyApp is a stateless widget – it does not hold mutable state
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // MaterialApp provides the basic visual layout and theme for the app
    return MaterialApp(
      title: 'Text Update Example', // Title shown in task switcher
      home: TextUpdateApp(), // The main screen widget
    );
  }
}

// Stateful widget because the text will change dynamically
class TextUpdateApp extends StatefulWidget {
  @override
  _TextUpdateAppState createState() => _TextUpdateAppState();
}

// The state class holds data that can change (mutable)
class _TextUpdateAppState extends State<TextUpdateApp> {
  // This variable stores the current text entered by the user
  String labelText = '';

  @override
  Widget build(BuildContext context) {
    // Scaffold gives a basic visual structure: AppBar + body
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Update Example'), // Title displayed in AppBar
      ),
      body: Center(
        // Center widget centers its child (the Column) on the screen
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Vertically center content
          children: <Widget>[
            // ===============================
            // BOX DISPLAYING USER TEXT INPUT
            // ===============================
            Container(
              width: 150.0,  // Fixed width for the box
              height: 150.0, // Fixed height for the box
              decoration: BoxDecoration(
                // Add a green border around the box
                border: Border.all(
                  color: Colors.green,
                  width: 5.0, // Thickness of the border
                ),
              ),
              alignment: Alignment.center, // Center the text inside the box
              child: Text(
                labelText, // The text displayed (updated live)
                style: TextStyle(fontSize: 20.0, color: Colors.black),
              ),
            ),

            // Add vertical space between the box and text field
            SizedBox(height: 20.0),

            // ===============================
            // TEXT INPUT FIELD
            // ===============================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0), // Add horizontal margin
              child: TextFormField(
                style: TextStyle(fontSize: 24), // Font size for input text
                // Triggered whenever user types something
                onChanged: (text) {
                  setState(() {
                    // Update the state so the UI refreshes with new text
                    labelText = text;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Enter Text', // Hint/label shown above the field
                  labelStyle: TextStyle(fontSize: 24), // Style for the label
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
