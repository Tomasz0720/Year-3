import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final List<String> items = const ['Dog', 'Cat', 'Rabbit', 'Hamster', 'Parrot'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ListView.separated',
      home: Scaffold(
        appBar: AppBar(title: const Text('Text Separator')),
        body: ListView.separated(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(Icons.pets),
              title: Text(items[index]),
            );
          },
          // Use text as separator
          separatorBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'Separator $index',
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ),
      ),
    );
  }
}
