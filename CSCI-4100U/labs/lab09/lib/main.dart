import 'package:flutter/material.dart';
import 'part01.dart';
import 'part02.dart';
import 'part03.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 09 - Images & Gallery',
      theme: ThemeData(useMaterial3: true, primarySwatch: Colors.teal),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lab 09 - Images & Gallery')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const Part1Page()),
                );
              },
              child: const Text('Part 01 - Display Network Image with States'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const Part2Page()),
                );
              },
              child: const Text('Part 02 - Zoom & Move'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const GalleryScreen()),
                );
              },
              child: const Text('Part 3 - Gallery'),
            ),
          ],
        ),
      ),
    );
  }
}

class Part1Page extends StatelessWidget {
  const Part1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Part 01 - Display Network Image with States'),
        // automatic back button is shown when pushed via Navigator
      ),
      body: const Center(child: Part01()), // from part01.dart
    );
  }
}

class Part2Page extends StatelessWidget {
  const Part2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Part 02 - Zoom & Move')),
      body: const Center(child: Part02()), // from part02.dart
    );
  }
}

class Part3Page extends StatelessWidget {
  const Part3Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Part 3 - Gallery')),
      body: const Center(child: Part03()), // from part03.dart
    );
  }
}