import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: BasicGridCount());
  }
}

class BasicGridCount extends StatelessWidget {
  const BasicGridCount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GridView.count — Basic')),
      body: GridView.count(
        // Fixed number of columns across the cross axis
        crossAxisCount: 3,
        // Space between tiles (both main & cross axes)
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        padding: const EdgeInsets.all(12),
        children: List.generate(
          10,
              (i) => Container(
            // Simple colored boxes to visualize a grid
            color: Colors.primaries[i % Colors.primaries.length],
            alignment: Alignment.center,
            child: Text(
              'Box $i',
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
