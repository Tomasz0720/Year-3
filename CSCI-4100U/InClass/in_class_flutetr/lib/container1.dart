import 'package:flutter/material.dart';

void main() {
  runApp(MyApp()); // Entry point → runs MyApp widget
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Column Visible Example',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Column Visible Example"),
        ),

        body: Center(
          // Center puts the child in the middle of the screen
          child: Container(
            width: 250,
            height: 250,
            color: Colors.blue, // outer container (blue background)

            // Column itself is also inside a Container to make it visible
            child: Container(
              width: 200, // set explicit width for the Column
              height: 200, // set explicit height for the Column
              color: Colors.red, // make Column visible with red background

              // Column is still a layout widget that stacks its children vertically
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // center vertically
                crossAxisAlignment: CrossAxisAlignment.center, // center horizontally
                children: [
                  Text(
                    "Item 1",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(height: 10), // spacing between items
                  Text(
                    "Item 2",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Item 3",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
