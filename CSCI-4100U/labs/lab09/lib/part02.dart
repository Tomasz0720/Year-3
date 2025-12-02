import 'package:flutter/material.dart';

void main() => runApp(const Part02());

class Part02 extends StatelessWidget {
  const Part02({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Part 02 - Zoom & Move',
      home: Scaffold(
        appBar: AppBar(
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Part 02'),
              Text('Zoom & Move'),
            ],
          ),
        ),
        body: const Center(
          child: ImageZoomPan(),
        ),
      ),
    );
  }
}

// StatefulWidget for zoom and pan functionality
class ImageZoomPan extends StatefulWidget {
  const ImageZoomPan({super.key});

  @override
  State<ImageZoomPan> createState() => _ImageZoomPanState();
}

class _ImageZoomPanState extends State<ImageZoomPan> {
  // State variables for zoom and translation
  double _scale = 1.0;
  double _offsetX = 0.0;
  double _offsetY = 0.0;

  // Constraints
  static const double minScale = 0.5;
  static const double maxScale = 3.0;
  static const double scaleStep = 0.2;
  static const double translateStep = 20.0;
  static const double maxOffset = 200.0;

  // Zoom functions
  void _zoomIn() {
    setState(() {
      if (_scale < maxScale) {
        _scale += scaleStep;
      }
    });
  }

  void _zoomOut() {
    setState(() {
      if (_scale > minScale) {
        _scale -= scaleStep;
      }
    });
  }

  // Movement functions
  void _moveUp() {
    setState(() {
      if (_offsetY < maxOffset) {
        _offsetY += translateStep;
      }
    });
  }

  void _moveDown() {
    setState(() {
      if (_offsetY > -maxOffset) {
        _offsetY -= translateStep;
      }
    });
  }

  void _moveLeft() {
    setState(() {
      if (_offsetX < maxOffset) {
        _offsetX += translateStep;
      }
    });
  }

  void _moveRight() {
    setState(() {
      if (_offsetX > -maxOffset) {
        _offsetX -= translateStep;
      }
    });
  }

  // Reset function
  void _reset() {
    setState(() {
      _scale = 1.0;
      _offsetX = 0.0;
      _offsetY = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start, // buttons at top
      children: [
        const SizedBox(height: 40),

        //Zoom and movement buttons
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 12,
          runSpacing: 12,
          children: [
            _buildControlButton(Icons.add, _zoomIn),
            _buildControlButton(Icons.remove, _zoomOut),
            _buildControlButton(Icons.arrow_upward, _moveDown),
            _buildControlButton(Icons.arrow_downward, _moveUp),
            _buildControlButton(Icons.arrow_back, _moveRight),
            _buildControlButton(Icons.arrow_forward, _moveLeft),
          ],
        ),

        const SizedBox(height: 20),

        // Reset button
        ElevatedButton(
          onPressed: _reset,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: const Text('Reset'),
        ),

        const SizedBox(height: 20),

        // Status text
        Text(
          'Zoom: ${_scale.toStringAsFixed(1)}x   X: ${_offsetX.toInt()}   Y: ${_offsetY.toInt()}',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),

        const SizedBox(height: 20),

        // Image area
        Expanded(
          child: Center(
            child: Container(
              width: 350,
              height: 250,
              color: Colors.grey[200],
              child: Center(
                child: Transform.translate(
                  offset: Offset(_offsetX, _offsetY),
                  child: Transform.scale(
                    scale: _scale,
                    child: Image.network(
                      'https://picsum.photos/300/200',
                      fit: BoxFit.contain,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(Icons.error, color: Colors.red, size: 48),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildControlButton(IconData icon, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(16),
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        side: const BorderSide(color: Colors.blue),
        elevation: 0,
      ),
      child: Icon(icon, size: 20),
    );
  }
}
