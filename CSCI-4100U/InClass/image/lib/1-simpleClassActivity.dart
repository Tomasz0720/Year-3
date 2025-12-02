import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            // Top image
            Expanded(
              child: Image.network(
                'https://picsum.photos/400/300',
                width: double.infinity,
                fit: BoxFit.cover,
              )
              //?
            ),

            // Small space between
            const SizedBox(height: 10),

            // Bottom image
            Expanded(
              child: Image.network(
                'https://picsum.photos/500/300',
                width: double.infinity,
                fit: BoxFit.cover,
              )
              //?
            ),
          ],
        ),
      ),
    );
  }
}
