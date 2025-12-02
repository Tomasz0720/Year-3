import 'package:flutter/material.dart';

// Entry point of the Flutter application.
void main() => runApp(const GalleryApp());

// Root widget of the app. Stateless because it doesn’t manage internal state.
class GalleryApp extends StatelessWidget {
  const GalleryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Online Gallery',

      // Basic color theme and visual style.
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true, // enables Material 3 design (modern UI)
      ),

      // The main screen of the app.
      home: const GalleryScreen(),
    );
  }
}

// The main screen showing a grid of online images.
class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  // A static list of image URLs from the Picsum free image service.
  final List<String> imageUrls = const [
    'https://picsum.photos/id/1015/600/400',
    'https://picsum.photos/id/1025/600/400',
    'https://picsum.photos/id/1035/600/400',
    'https://picsum.photos/id/1045/600/400',
    'https://picsum.photos/id/1055/600/400',
    'https://picsum.photos/id/1065/600/400',
    'https://picsum.photos/id/1075/600/400',
    'https://picsum.photos/id/1085/600/400',
    'https://picsum.photos/id/1095/600/400',
    'https://picsum.photos/id/1105/600/400',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Online Image Gallery')),

      // Adds padding around the grid.
      body: Padding(
        padding: const EdgeInsets.all(8.0),

        // GridView.builder dynamically builds the image grid as you scroll.
        child: GridView.builder(
          itemCount: imageUrls.length,

          // Defines how the grid is structured (2 columns, spacing between items).
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,       // number of columns (2 images per row)
            crossAxisSpacing: 8.0,   // space between columns
            mainAxisSpacing: 8.0,    // space between rows
          ),

          // Builds each grid tile (thumbnail) one by one.
          itemBuilder: (context, index) {
            final url = imageUrls[index]; // get current image URL

            return GestureDetector(
              // Detects taps on the image to open fullscreen view.
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FullScreenImage(imageUrl: url),
                  ),
                );
              },

              // Hero widget provides a smooth zoom animation between screens.
              child: Hero(
                tag: url, // unique tag linking this image to the fullscreen version
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10), // rounded corners
                  child: Image.network(
                    url,
                    fit: BoxFit.cover, // fill the box and crop if necessary

                    // Shows a circular progress indicator while loading.
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },

                    // Displays an error icon if image fails to load.
                    errorBuilder: (context, error, stackTrace) =>
                    const Center(child: Icon(Icons.error, size: 40)),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Displays the selected image in full screen with zoom and pan support.
class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  const FullScreenImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // dark background for gallery feel
      appBar: AppBar(backgroundColor: Colors.transparent), // no visible bar color

      // Center the image on screen.
      body: Center(
        // Hero animation (matches the same tag from the grid view).
        child: Hero(
          tag: imageUrl,
          // InteractiveViewer allows pinch-to-zoom and drag gestures.
          child: InteractiveViewer(
            minScale: 0.8, // minimum zoom level
            maxScale: 4.0, // maximum zoom level
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain, // keep full image visible without cropping

              // Fallback icon if image fails to load.
              errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.error, color: Colors.white, size: 50),
            ),
          ),
        ),
      ),
    );
  }
}
