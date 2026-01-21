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
        appBar: AppBar(title: const Text('Icon Separator')),
        body: ListView.separated(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(Icons.pets),
              title: Text(items[index]),
            );
          },
          // Add an icon as separator
          separatorBuilder: (context, index) => const Padding(

            padding: EdgeInsets.symmetric(vertical: 8),
            child: Icon(Icons.star, color: Colors.orange),
          ),
        ),
      ),
    );
  }
}
