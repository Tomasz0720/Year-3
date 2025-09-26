import 'package:flutter/material.dart';

void main() {
  runApp(MyApp()); // Entry point → runs MyApp widget
}

class MyApp extends StatelessWidget { // Stateless widget because its content doesn't change (static)
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Center Example',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Center Widget Example"),
        ),

        // The body of the app
        body: Center(
          // Center widget takes one child and places it
          // in the MIDDLE of its parent (both horizontally and vertically)
          child: Container(
            width: 150,
            height: 150,
            color: Colors.blue, // a blue box

            // Inside the blue box, we add text
            child: Center(
              // This Center ensures the text is also centered INSIDE the container
              child: Text(
                "Hello Center!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center, // aligns multi-line text
              ),
            ),
          ),
        ),
      ),
    );
  }
}
