import 'package:flutter/material.dart';

void main() {
  runApp(MyApp()); // Entry point → runs MyApp widget
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stack Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Stack UI Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),

      // Center widget puts Stack in the middle of the screen
      body: Center(
        // Stack = allows widgets to be placed on top of each other (like layers)
        child: Stack(
          alignment: Alignment.center,
          // Controls how children are aligned inside the Stack
          children: [
            // Bottom-most layer (background)
            Container(
              width: 200,
              height: 200,
              color: Colors.blue, // a blue square
            ),

            // Middle layer
            Container(
              width: 150,
              height: 150,
              color: Colors.green, // smaller green square
            ),

            // Top-most layer
            Container(
              width: 100,
              height: 100,
              color: Colors.red, // smallest red square
            ),

            // Text placed on top of everything
            Text(
              "Stack",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
