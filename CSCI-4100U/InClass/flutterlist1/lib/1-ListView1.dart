import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basic ListView',
      home: Scaffold(
        appBar: AppBar(title: Text('Basic ListView Example')),
        body: ListView(
          // A simple list of text widgets
          children: [
            Text('Item 1'),
            Text('Item 2'),
            Text('Item 3'),
            Text('Item 4'),
          ],
        ),
      ),
    );
  }
}
