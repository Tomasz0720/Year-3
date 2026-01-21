import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: ComplexTabs()));

class ComplexTabs extends StatelessWidget {
  const ComplexTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // 2 tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Complex Tabbed App'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Contacts', icon: Icon(Icons.people)),
              Tab(text: 'Gallery', icon: Icon(Icons.grid_on)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // TAB 1: a scrollable list
            ListView.builder(
              itemCount: 15,
              itemBuilder: (context, i) {
                return ListTile(
                  leading: CircleAvatar(child: Text('${i + 1}')),
                  title: Text('Contact ${i + 1}'),
                  subtitle: const Text('Tap to open profile'),
                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Clicked Contact ${i + 1}')),
                  ),
                );
              },
            ),

            // TAB 2: a grid of colored boxes
            GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,      // 3 columns
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: 12,
              itemBuilder: (context, i) {
                final color = Colors.primaries[i % Colors.primaries.length];
                return Container(
                  decoration: BoxDecoration(
                    color: color.shade300,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Pic $i',
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
