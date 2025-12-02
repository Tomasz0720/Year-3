import 'package:flutter/material.dart';

// Entry point of the Flutter application.
// 'runApp()' starts the app and inflates the given widget (OnlineImageApp).
void main() => runApp(const OnlineImageApp());

// The main root widget of the app.
// 'StatelessWidget' means this widget does not have any mutable state.
class OnlineImageApp extends StatelessWidget {
  const OnlineImageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Title of the app (mainly used by the OS or when switching apps).
      title: 'Online Image Example',

      // 'home' defines the main screen (or root page) of the app.
      home: Scaffold(
        // Basic app layout structure: AppBar + body area.
        appBar: AppBar(title: const Text('Online Image Example')),

        // Center widget aligns its child in the middle of the screen.
        body: const Center(
          // Our custom widget that shows an online image.
          child: ImageExample(),
        ),
      ),
    );
  }
}

// A custom widget to demonstrate loading an image from the internet.
class ImageExample extends StatelessWidget {
  const ImageExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      // The URL of the image to load from the web.
      // This sample uses the free random image service "Picsum".
      'https://picsum.photos/400/300',

      // The width and height define how large the image appears in the layout.
      width: 300,
      height: 200,

      // 'fit' determines how the image should be resized to fit its box.
      // BoxFit.cover will fill the entire box, cropping parts if necessary.
      fit: BoxFit.cover,

      // 'loadingBuilder' is called while the image is still being downloaded.
      // It allows showing a loading indicator (spinner) until the image appears.
      loadingBuilder: (context, child, loadingProgress) {
        // If loadingProgress is null, it means the image is fully loaded.
        if (loadingProgress == null) return child;

        // Otherwise, show a circular loading spinner.
        return const Center(child: CircularProgressIndicator());
      },

      // 'errorBuilder' is called if the image fails to load (e.g., bad URL or no internet).
      errorBuilder: (context, error, stackTrace) {
        // Display a friendly error message instead of a blank box.
        return const Text('⚠️ Failed to load image');
      },
    );
  }
}
