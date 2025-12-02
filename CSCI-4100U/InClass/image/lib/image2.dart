import 'package:flutter/material.dart';

// Entry point of the app.
// 'runApp()' tells Flutter to start the app with the given widget (ZoomApp).
void main() => runApp(const ZoomApp());

// The root widget of the app.
// Uses 'StatelessWidget' since this part of the UI does not change.
class ZoomApp extends StatelessWidget {
  const ZoomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application title (visible when switching apps on some devices).
      title: 'Zoom In / Out Example',

      // 'home' defines the main page displayed when the app starts.
      home: Scaffold(
        // Basic page layout with a title bar (AppBar) and a body.
        appBar: AppBar(title: const Text('Zoom In / Out Example')),

        // The main content of the page (our zoom example widget).
        body: const ZoomExample(),
      ),
    );
  }
}

// A stateful widget — because zooming in/out requires changing the UI dynamically.
class ZoomExample extends StatefulWidget {
  const ZoomExample({super.key});

  @override
  State<ZoomExample> createState() => _ZoomExampleState();
}

// The state class that holds the current zoom value and updates the UI.
class _ZoomExampleState extends State<ZoomExample> {
  // Current zoom scale. Starts at 1.0 (normal size).
  double _scale = 1.0;

  // Increases the scale value — zooms in.
  void _zoomIn() {
    setState(() {
      _scale += 0.2; // increment zoom by 0.2 each time
    });
  }

  // Decreases the scale value — zooms out.
  void _zoomOut() {
    setState(() {
      // Prevents zooming out too far (less than 0.4x).
      if (_scale > 0.4) _scale -= 0.2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // Vertically center the content.
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Expanded makes the image area take all remaining vertical space.
        Expanded(
          child: Center(
            // 'Transform.scale' applies a zoom effect by scaling the widget.
            child: Transform.scale(
              scale: _scale, // current zoom level
              child: Image.asset(
                'assets/images/green.png', // local image in assets folder
                fit: BoxFit.contain, // scales image without cropping
              ),
            ),
          ),
        ),

        const SizedBox(height: 16), // small gap below image

        // A row with two buttons: Zoom Out and Zoom In.
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Button to zoom out
            ElevatedButton(
              onPressed: _zoomOut,
              child: const Text('– Zoom Out'),
            ),
            const SizedBox(width: 20), // space between buttons
            // Button to zoom in
            ElevatedButton(
              onPressed: _zoomIn,
              child: const Text('+ Zoom In'),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Display the current zoom value (formatted to one decimal place).
        Text('Current Zoom: ${_scale.toStringAsFixed(1)}x'),

        const SizedBox(height: 20),
      ],
    );
  }
}
