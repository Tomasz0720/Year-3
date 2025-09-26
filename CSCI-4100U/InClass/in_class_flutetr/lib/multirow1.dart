import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp()); // Entry point of the app → runs MyApp widget
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multiple Rows Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // First screen of the app
      home: const MyHomePage(title: 'Multiple Rows Example'),
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
  @override
  Widget build(BuildContext context) {
    // Scaffold = a full page layout with AppBar, Body, FloatingActionButton, etc.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        // Center = puts its child in the middle of the screen
        child: Column(
          // Column = vertical layout → stacks widgets top-to-bottom
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // -------- First Row --------
            // A Row arranges children horizontally (left to right)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisAlignment controls horizontal alignment
              // Try changing to: start, end, spaceAround, spaceBetween, spaceEvenly
              children: const [
                Icon(Icons.star, color: Colors.red, size: 40),
                SizedBox(width: 15), // adds spacing between items in Row
                Icon(Icons.star, color: Colors.green, size: 40),
                SizedBox(width: 15),
                Icon(Icons.star, color: Colors.blue, size: 40),
              ],
            ),

            SizedBox(height: 20), // spacing between Row 1 and Row 2

            // -------- Second Row --------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // spaceEvenly = equal spacing between all children
              children: const [
                Text("Row 2 - Item 1", style: TextStyle(fontSize: 18)),
                Text("Row 2 - Item 2", style: TextStyle(fontSize: 18)),
                Text("Row 2 - Item 3", style: TextStyle(fontSize: 18)),
              ],
            ),

            SizedBox(height: 20), // spacing between Row 2 and Row 3

            // -------- Third Row --------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // spaceAround = equal space around each child
              children: const [
                Icon(Icons.phone, color: Colors.purple, size: 40),
                Icon(Icons.message, color: Colors.orange, size: 40),
                Icon(Icons.camera_alt, color: Colors.teal, size: 40),
              ],
            ),

            const SizedBox(height: 20),
            // Extra explanation text
            const Text(
              "This screen shows 3 Rows stacked vertically using a Column.",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
