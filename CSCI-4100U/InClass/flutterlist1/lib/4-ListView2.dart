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
  Widget build(BuildContext context) { // Context is the location in the widget tree where this widget builds parent.
    return MaterialApp(
      title: 'ListView.builder',
      home: Scaffold(
        appBar: AppBar(title: Text('Dynamic ListView.builder')),
        body: ListView.builder(

          itemCount: items.length,

          itemBuilder: (context, index){
            return ListTile(
              leading: Icon(Icons.access_alarms),
              title: Text("This is my text"),
            );
          }

        ),
      ),
    );
  }
}


















