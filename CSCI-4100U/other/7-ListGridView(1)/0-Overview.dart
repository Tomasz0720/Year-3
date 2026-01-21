import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Widget Review',
      home: Scaffold(
        appBar: AppBar(title: const Text("Review: Basic Widgets")),
        body: Center( // (1) Center widget - centers everything inside
          child: Column( // (2) Column - vertical arrangement
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // =========================
              // CONTAINER with margin, padding, and text
              // =========================
              Container(
                margin: const EdgeInsets.all(12), // (3) Margin outside
                padding: const EdgeInsets.all(16), // (4) Padding inside
                color: Colors.blue.shade100,
                child: const Text(
                  "This is inside a Container",
                  style: TextStyle(fontSize: 16),
                ),
              ),

              const SizedBox(height: 20),

              // =========================
              // ROW Example
              // =========================
              Row( // (5) Row - horizontal arrangement
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.star, color: Colors.orange),
                  SizedBox(width: 10),
                  Text("Row with Icon and Text"),
                ],
              ),

              const SizedBox(height: 20),

              // =========================
              // ALIGN Example
              // =========================
              Align( // (6) Align - place widget in a corner
                alignment: Alignment.bottomRight,
                child: Container(
                  color: Colors.green.shade100,
                  padding: const EdgeInsets.all(8),
                  child: const Text("Aligned to bottom right"),
                ),
              ),

              const SizedBox(height: 20),

              // =========================
              // STACK + POSITIONED
              // =========================
              SizedBox(
                height: 150,
                width: 150,
                child: Stack(
                  children: [
                    Container(
                      color: Colors.red.shade100,
                      child: const Center(
                        child: Text("Stack Base Box"),
                      ),
                    ),
                    Positioned( // (7) Positioned widget
                      top: 10,
                      right: 10,
                      child: Container(
                        color: Colors.yellow,
                        padding: const EdgeInsets.all(4),
                        child: const Text("Top-Right"),
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
