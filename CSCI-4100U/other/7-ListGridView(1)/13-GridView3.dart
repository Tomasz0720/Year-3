import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: GridFixedBuilder()));

/// StatelessWidget because data does not change in this example
class GridFixedBuilder extends StatelessWidget {
  const GridFixedBuilder({super.key});

  // Sample "data" (like products) stored in a List of Maps
  // In real apps this might come from an API or a database
  final List<Map<String, dynamic>> products = const [
    {'name': 'Apple', 'icon': Icons.apple, 'price': 1.99},
    {'name': 'Banana', 'icon': Icons.local_grocery_store, 'price': 0.99},
    {'name': 'Cherry', 'icon': Icons.emoji_food_beverage, 'price': 2.49},
    {'name': 'Mango', 'icon': Icons.spa, 'price': 3.49},
    {'name': 'Orange', 'icon': Icons.sunny, 'price': 1.49},
    {'name': 'Grape', 'icon': Icons.sports_rugby, 'price': 2.99},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar with title
      appBar: AppBar(title: const Text('GridView.builder + Fixed Columns')),

      // The body contains a grid of items
      body: GridView.builder(
        padding: const EdgeInsets.all(12), // outer spacing around the grid

        // Controls how the grid is laid out
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,          // 2 columns across the screen
          crossAxisSpacing: 12,       // horizontal gap between tiles
          mainAxisSpacing: 12,        // vertical gap between tiles
          childAspectRatio: 3 / 2,    // width-to-height ratio of each tile
        ),

        // Total number of items in the grid (same as products list length)
        itemCount: products.length,

        // Builds each grid item
        itemBuilder: (context, i) {
          final p = products[i]; // shorthand variable for this product

          return Card(
            elevation: 2, // small shadow for Material look
            //makes the card tappable with ripple effect.
            child: InkWell(
              // Tap effect and interaction
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Tapped ${p['name']}')),
              ),

              // Content of each grid tile
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // center vertically
                children: [
                  // Show the product's icon
                  Icon(p['icon'] as IconData, size: 36),

                  const SizedBox(height: 8), // small vertical spacing

                  // Show the product name and price
                  Text('${p['name']} • \$${p['price']}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
