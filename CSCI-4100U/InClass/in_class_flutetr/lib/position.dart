import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Positioned Example',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Positioned Widget Example"),
        ),
        body: Stack(
          // Stack allows widgets to be placed on top of each other
          children: [
            // Background widget
            Container(
              color: Colors.grey[300], // background color for visibility
            ),

            // Example 1: Positioned at top-left
            Positioned(
              top: 20.0,   // distance from the top
              left: 20.0,  // distance from the left
              child: Text(
                "First name:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            // Example 2: Positioned at bottom-right
            Positioned(
              bottom: 20.0, // distance from the bottom
              right: 20.0,  // distance from the right
              child: Text(
                "Last name:",
                style: TextStyle(fontSize: 20, color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
