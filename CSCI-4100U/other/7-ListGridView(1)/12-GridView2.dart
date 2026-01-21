import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: GridExtentResponsive()));

class GridExtentResponsive extends StatelessWidget {
  const GridExtentResponsive({super.key});

  @override
  Widget build(BuildContext context) {
    // This grid chooses how many columns to show based on available width:
    // it guarantees each tile’s max width, and computes columns automatically.
    return Scaffold(
      appBar: AppBar(title: const Text('GridView.extent — Responsive')),
      body: GridView.extent(
        padding: const EdgeInsets.all(12),
        maxCrossAxisExtent: 160, // <= Max tile width; columns auto-fit to width
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1,     // Square tiles (1:1)
        children: List.generate(20, (i) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.primaries[i % Colors.primaries.length].shade300,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Text(
              'Tile $i',
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          );
        }),
      ),
    );
  }
}
