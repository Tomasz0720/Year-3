import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final List<String> items = const [
    'Apple',
    'Banana',
    'Cherry',
    'Mango',
    'Orange',
    'Pineapple'
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ListView.builder',
      home: Scaffold(
        appBar: AppBar(title: Text('Dynamic ListView.builder')),
        body: ListView.builder(
          //
          // number of items in the list
          itemCount: items.length,
          // itemBuilder builds widgets on demand (better performance)
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(Icons.star),
              title: Text(items[index]),
            );
          },
        ),
      ),
    );
  }
}


















