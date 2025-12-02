import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Show an Image',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Image Example'),
          backgroundColor: Colors.teal,
        ),
        body: const Center(
          child: ImageExample(),
        ),
      ),
    );
  }
}

class ImageExample extends StatelessWidget {
  const ImageExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/green.png',
      width: 250,
      height: 250, //500
      fit: BoxFit.cover, // Try cover, contain, fill
    );
  }
}
