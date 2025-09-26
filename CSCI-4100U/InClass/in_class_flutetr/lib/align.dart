import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Align Example',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Align Widget Example"),
        ),
        body: Align(
          // Position the child in the bottom-right corner of the screen
          alignment: Alignment.bottomRight,

          // The child widget we are aligning
          child: Text(
            "I am at Bottom Right!",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}
