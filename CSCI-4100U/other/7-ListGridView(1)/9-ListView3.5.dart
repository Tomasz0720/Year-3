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
        appBar: AppBar(title: const Text('Gradient Separator')),
        body: ListView.separated(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(Icons.pets),
              title: Text(items[index]),
            );
          },
          // Fancy gradient line
          separatorBuilder: (context, index) => Container(
            height: 4,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple, Colors.red],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
