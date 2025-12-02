import 'package:flutter/material.dart';

// Entry point of the Flutter app.
// 'runApp()' launches the app and displays the given widget.
void main() => runApp(const MyApp());

// The root widget of the app.
// It defines the overall app structure and navigation.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // App title (used by the OS and task switcher).
      title: 'Image Settings Demo',

      // The main screen of the app.
      home: Scaffold(
        // A standard layout structure with an AppBar and body area.
        appBar: AppBar(title: const Text('Image Settings Example')),

        // The main content widget that demonstrates different image properties.
        body: const ImageSettingsDemo(),
      ),
    );
  }
}

// A stateless widget showing various ways to display and style images in Flutter.
class ImageSettingsDemo extends StatelessWidget {
  const ImageSettingsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // Adds padding around all the content.
      padding: const EdgeInsets.all(16),

      // Allows vertical scrolling so all examples are visible on smaller screens.
      child: Column(
        // Align text and examples to the start (left) of the screen.
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          // --- 1️⃣ BASIC IMAGE ---
          const Text('1️⃣  Basic Image (default sizing):'),
          const SizedBox(height: 8),
          // Displays an image from the assets folder at its original size.
          Image.asset('assets/images/green.png'),

          const Divider(), // Horizontal separator line

          // --- 2️⃣ FIXED SIZE ---
          const Text('2️⃣  Fixed width / height:'),
          const SizedBox(height: 8),
          // You can specify exact width and height for the image.
          Image.asset(
            'assets/images/green.png',
            width: 150,
            height: 100,
          ),

          const Divider(),

          // --- 3️⃣ FIT MODES (BoxFit) ---
          const Text('3️⃣  Fit Modes (BoxFit):'),
          const SizedBox(height: 8),
          Row(
            children: [
              // BoxFit.contain → Fits the image entirely inside its box (no cropping).
              Expanded(
                child: Image.asset(
                  'assets/images/green.png',
                  //The image is fully visible inside the container.
                  // It keeps its aspect ratio (shape) and never gets cropped.
                  //May leave empty space
                  fit: BoxFit.contain,
                  height: 50,
                ),
              ),

              // BoxFit.cover → Covers the entire box, cropping parts of the image if needed.
              Expanded(
                child: Image.asset(
                  'assets/images/green.png',
                  //The image completely covers the container.
                  // It keeps its aspect ratio but crops anything that doesn’t fit.
                  fit: BoxFit.cover,
                  height: 50,
                ),
              ),

              // BoxFit.fill → Stretches the image to fill both width and height (may distort).
              Expanded(
                child: Image.asset(
                  'assets/images/green.png',
                  //The image stretches to fill both width and height of the container.
                  // It does not preserve aspect ratio, so it can look distorted.
                  fit: BoxFit.fill,
                  height: 50,
                ),
              ),
            ],
          ),
          const Text('← contain | cover | fill'),

          const Divider(),

          // --- 4️⃣ ALIGNMENT & PADDING ---
          const Text('4️⃣  Alignment and Padding:'),
          const SizedBox(height: 8),
          // Container defines an area with a background color and padding.
          Container(
            color: Colors.grey.shade200, // light gray background
            height: 150,
            width: double.infinity, // take full width of screen
            // Aligns the image within the container.
            child: Image.asset(
              'assets/images/green.png',
              alignment: Alignment.bottomRight, // moves image to bottom-right corner
              fit: BoxFit.contain,
            ),
          ),

          const Divider(),

          // --- 5️⃣ ROUNDED CORNERS / CIRCLE CROP ---
          const Text('5️⃣  Rounded corners / Circle crop:'),
          const SizedBox(height: 8),
          Row(
            children: [
              // 'ClipRRect' gives the image rounded corners.
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/green.png',
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),

              // 'ClipOval' crops the image into a circular shape.
              ClipOval(
                child: Image.asset(
                  'assets/images/green.png',
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),

          const Divider(),

          // --- 6️⃣ COLOR FILTER & OPACITY ---
          const Text('6️⃣  Color filter & opacity:'),
          const SizedBox(height: 8),

          // Applies a red tint using 'ColorFiltered' with a blend mode.
          ColorFiltered(
            colorFilter: const ColorFilter.mode(Colors.redAccent, BlendMode.modulate),
            child: Image.asset('assets/images/green.png', width: 150),
          ),
          const SizedBox(height: 8),

          // Reduces the transparency of the image to 50%.
          Opacity(
            opacity: 0.5, // 0.0 = fully transparent, 1.0 = fully visible
            child: Image.asset('assets/images/green.png', width: 150),
          ),

          const Divider(),

          // --- 7️⃣ ERROR HANDLING ---
          const Text('7️⃣  Error handling (bad path):'),
          const SizedBox(height: 8),
          // If the image path is wrong, display a fallback message instead.
          Image.asset(
            'assets/images/does_not_exist.png',
            errorBuilder: (context, error, stack) =>
            const Text('⚠️ Could not load image'),
          ),
        ],
      ),
    );
  }
}
