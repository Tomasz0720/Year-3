import 'package:flutter/material.dart';

void main() {
  runApp(MyApp()); // Entry point → runs MyApp widget
}

// Our main app widget (Stateless because it does not hold changing data itself)
class MyApp extends StatelessWidget {
  // Constructor (no const here for teaching simplicity)
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi Row & Column Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Multi Row & Column Example'),
    );
  }
}

// StatefulWidget because later we could add interactions / state changes
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
        // AppBar at the top with title
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        // Column = vertical stacking → places rows on top of each other
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // -------- First Row (with multiple Columns inside) --------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // Row = horizontal layout
              children: [
                // Column #1 → stacks icon above text
                Column(
                  children: [
                    Icon(Icons.home, color: Colors.blue, size: 40),
                    SizedBox(height: 10), // vertical space inside Column
                    Text("Home"),
                  ],
                ),

                // Column #2
                Column(
                  children: [
                    Icon(Icons.search, color: Colors.green, size: 40),
                    SizedBox(height: 10),
                    Text("Search"),
                  ],
                ),

                // Column #3
                Column(
                  children: [
                    Icon(Icons.settings, color: Colors.red, size: 40),
                    SizedBox(height: 10),
                    Text("Settings"),
                  ],
                ),
              ],
            ),

            SizedBox(height: 40), // spacing between first and second row

            // -------- Second Row (with multiple Columns inside) --------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon(Icons.phone, color: Colors.purple, size: 40),
                    SizedBox(height: 10),
                    Text("Phone"),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.message, color: Colors.orange, size: 40),
                    SizedBox(height: 10),
                    Text("Message"),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.camera_alt, color: Colors.teal, size: 40),
                    SizedBox(height: 10),
                    Text("Camera"),
                  ],
                ),
              ],
            ),

            SizedBox(height: 40),

            // Extra description
            Text(
              "Above: Each Row contains multiple Columns.\n"
                  "Each Column stacks an Icon above a Text.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
