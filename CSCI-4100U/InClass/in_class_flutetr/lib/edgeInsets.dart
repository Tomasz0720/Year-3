import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EdgeInsets Demo',
      home: Scaffold(
        appBar: AppBar(title: Text("EdgeInsets Example")),
        body: SingleChildScrollView( // allows scrolling if content is tall
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ========================================================
              // Example 1: EdgeInsets.all
              // ========================================================
              Container(
                color: Colors.red,
                margin: EdgeInsets.all(20), // equal margin on all 4 sides
                padding: EdgeInsets.all(10), // equal padding inside
                child: Text(
                  "EdgeInsets.all(10.0)\n"
                      "Same padding/margin on ALL sides",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),

              // ========================================================
              // Example 2: EdgeInsets.symmetric (horizontal and vertical)
              // ========================================================
              Container(
                color: Colors.green,
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                // horizontal = left + right
                // vertical = top + bottom
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text(
                  "EdgeInsets.symmetric(horizontal: 20, vertical: 5)\n"
                      "Different values for horizontal & vertical",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),

              // ========================================================
              // Example 3: EdgeInsets.only (choose specific sides)
              // ========================================================
              Container(
                color: Colors.blue,
                margin: EdgeInsets.only(left: 50, top: 20),
                // margin only applied to LEFT and TOP
                padding: EdgeInsets.only(top: 10, right: 15),
                // padding only applied to TOP and RIGHT
                child: Text(
                  "EdgeInsets.only(top: 10, right: 15)\n"
                      "Apply margin/padding on specific sides",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),

              // ========================================================
              // Example 4: Compare margin vs padding
              // ========================================================
              Container(
                color: Colors.orange,
                margin: EdgeInsets.all(30),
                // pushes container away from neighbors (outside space)
                padding: EdgeInsets.all(20),
                // pushes child inward (inside space)
                child: Text(
                  "Margin = space OUTSIDE\n"
                      "Padding = space INSIDE",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
