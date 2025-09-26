import 'package:flutter/material.dart';

// The starting point of every Dart program.
void main() {
  // Tells Flutter to run the app and attach it to the screen, starting with the MyApp widget.
  runApp(const MyApp());
}

// This is my application (as a widget).
// We create our own custom widget by extending StatelessWidget or StatefulWidget.
// Here: StatelessWidget because the app itself doesn’t manage any changing data.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      // The home property defines the default screen shown at app launch.
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold gives you a ready-made app page layout (AppBar, Body, FAB, etc.)
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        // Center positions its child in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            // 🔹 Adding a Row Example Below
            const SizedBox(height: 30), // Just some spacing

            // Row is like Column, but arranges children horizontally (left → right).
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // Try changing to .spaceAround, .spaceBetween, etc. in class.
              children: <Widget>[
                Icon(Icons.star, color: Colors.red, size: 40),
                SizedBox(width: 20), // spacing between widgets in Row
                Icon(Icons.star, color: Colors.green, size: 40),
                SizedBox(width: 20),
                Icon(Icons.star, color: Colors.blue, size: 40),
              ],
            ),

            const SizedBox(height: 20),
            const Text("Above is an example of a Row with 3 icons."),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
