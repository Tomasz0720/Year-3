import 'package:flutter/material.dart';

void main() => runApp(const MoveImageApp());

class MoveImageApp extends StatelessWidget {
  const MoveImageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Move Image Example',
      home: Scaffold(
        appBar: AppBar(title: const Text('Move Image with Buttons')),
        body: const MoveImageExample(),
      ),
    );
  }
}

class MoveImageExample extends StatefulWidget {
  const MoveImageExample({super.key});

  @override
  State<MoveImageExample> createState() => _MoveImageExampleState();
}

class _MoveImageExampleState extends State<MoveImageExample> {
  double _offsetX = 0; // horizontal movement
  double _offsetY = 0; // vertical movement
  double _scale = 1.0; // optional zoom

  void _moveLeft() => setState(() => _offsetX -= 20);
  void _moveRight() => setState(() => _offsetX += 20);
  void _moveUp() => setState(() => _offsetY -= 20);
  void _moveDown() => setState(() => _offsetY += 20);

  void _zoomIn() => setState(() => _scale += 0.1);
  void _zoomOut() => setState(() {
    if (_scale > 0.3) _scale -= 0.1;
  });

  void _resetView() => setState(() {
    _offsetX = 0;
    _offsetY = 0;
    _scale = 1.0;
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: ClipRect(
              child: Transform.translate(
                offset: Offset(_offsetX, _offsetY),
                child: Transform.scale(
                  scale: _scale,
                  child: Image.asset(
                    'assets/images/green.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 8),
        Text(
          'X: ${_offsetX.toStringAsFixed(0)}   '
              'Y: ${_offsetY.toStringAsFixed(0)}   '
              'Zoom: ${_scale.toStringAsFixed(1)}x',
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),

        // Controls
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 8,
          runSpacing: 8,
          children: [
            ElevatedButton(onPressed: _moveUp, child: const Text('↑ Up')),
            ElevatedButton(onPressed: _moveDown, child: const Text('↓ Down')),
            ElevatedButton(onPressed: _moveLeft, child: const Text('← Left')),
            ElevatedButton(onPressed: _moveRight, child: const Text('→ Right')),
            ElevatedButton(onPressed: _zoomIn, child: const Text('+ Zoom In')),
            ElevatedButton(onPressed: _zoomOut, child: const Text('– Zoom Out')),
            OutlinedButton(onPressed: _resetView, child: const Text('Reset')),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
