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
        appBar: AppBar(title: const Text('Custom Separator Practice')),
        body: ListView.separated( //?-A
          itemCount: items.length,
          itemBuilder: (context, index) { //?-B
            return ListTile( //?-C
              leading: const Icon(Icons.pets),
              title: Text(items[index]), //?-D
            );
          },

          // ✅ SOLUTION: Custom separator
          separatorBuilder: (context, index) => Container( //?-E
            height: 6, // changed thickness
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.green], // new gradient colors
              ),
            ),
          ),
        ),
      ),
    );
  }
}
