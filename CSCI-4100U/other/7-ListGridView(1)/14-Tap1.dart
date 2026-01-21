import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: SimpleTabs()));

class SimpleTabs extends StatelessWidget {
  const SimpleTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Simple Tabbed App'),
          bottom: const TabBar(
            // tabs are scrollable if you have many
            isScrollable: true,
            tabs: [
              Tab(text: 'Tab 1', icon: Icon(Icons.add)),
              Tab(text: 'Tab 2', icon: Icon(Icons.remove)),
            ],
          ),
        ),
        body: const TabBarView(
          // Each tab corresponds to one widget in the same order
          children: [
            Center(child: Text('Content for Tab 1')),
            Center(child: Text('Content for Tab 2')),
          ],
        ),
      ),
    );
  }
}
