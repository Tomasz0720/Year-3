import 'package:flutter/material.dart';

void main() {
  runApp(MyApp()); // Entry point
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'In-Class Practice',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Practice: Container, Center, Align"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // ==========================
            // 1) CONTAINER PRACTICE
            // ==========================
            // TODO: Wrap this Text in a Container
            // - Give the container width: 150, height: 100
            // - Add a background color (any color)
            // - Place the Text inside the container
            //
            // Example of expected result:
            // A colored box with text inside
            //
            Container(
              width: 150,
              height: 150,
              color: Colors.green,
              child: Text("I am inside a Container"),
            ),

            Text("TODO: Practice Container here"),


            SizedBox(height: 40), // spacing between exercises


            // ==========================
            // 2) CENTER PRACTICE
            // ==========================
            // TODO: Use Center widget
            // - Put a Container as its child
            // - Make the container width: 120, height: 80, color: Colors.blue
            // - Inside the container, add a Text("Centered Text")
            // - Make sure the text is centered inside the container
            //
            // Example of expected result:
            // A blue box in the center of the screen with centered text
            //
            Center(
              child: Container(
                width: 120,
                height: 80,
                color: Colors.blue,
                child: Center(
                  child: Text("Centered Text"),
                ),
              ),
            ),

            Text("TODO: Practice Center here"),


            SizedBox(height: 40), // spacing between exercises


            // ==========================
            // 3) ALIGN PRACTICE
            // ==========================
            // TODO: Use Align widget
            // - Align a Text widget to the bottomRight
            // - Text should say: "I am bottom right!"
            // - Style the text with fontSize: 18 and color: Colors.red
            //
            // Example of expected result:
            // The text should appear at the bottom-right corner
            //
            Align(
              alignment: Alignment.bottomRight,
              child: Text("I am bottom right!", style: TextStyle(fontSize: 18, color: Colors.red) ),
            ),

            Text("TODO: Practice Align here"),
          ],
        ),
      ),
    );
  }
}