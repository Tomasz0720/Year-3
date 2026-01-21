// 1. Bottom Navigation (COMPLETED)
// 2. Image gallery in the first tab (COMPLETED)
// 3. Show Snackbar on image tap (PARTIALLY COMPLETED)
// 4. Schedule a local notification (3 seconds later) (NOT COMPLETED)
// 5. Handle notification tap: switch tab and show image full-screen (PARTIALLY COMPLETED)

import 'package:flutter/material.dart';

void main() => runApp(const Part03());

class Part03 extends StatelessWidget {
  const Part03({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Gallery',

      // Basic color theme and visual style.
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true, // enables Material 3 design (modern UI)
      ),

      // The main screen of the app.
      home: BottomNavExample(),

    );
  }
}

// The main screen showing a grid of online images.
class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  // A static list of image URLs from the Picsum free image service.
  final List<String> imageUrls = const [
    'https://picsum.photos/id/1015/600/400',
    'https://picsum.photos/id/1016/600/400',
    'https://picsum.photos/id/1050/600/400',
    'https://picsum.photos/id/1018/600/400',
    'https://picsum.photos/id/1019/600/400',
    'https://picsum.photos/id/1020/600/400',
    'https://picsum.photos/id/1021/600/400',
    'https://picsum.photos/id/1022/600/400',
    'https://picsum.photos/id/1023/600/400',
    'https://picsum.photos/id/1024/600/400',
    'https://picsum.photos/id/1025/600/400',
    'https://picsum.photos/id/1026/600/400',
    'https://picsum.photos/id/1027/600/400',
    'https://picsum.photos/id/1028/600/400',
    'https://picsum.photos/id/1029/600/400',
    'https://picsum.photos/id/1036/600/400',
    'https://picsum.photos/id/1039/600/400',
    'https://picsum.photos/id/1032/600/400',
    'https://picsum.photos/id/1033/600/400',
    'https://picsum.photos/id/1060/600/400',

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Photo Gallery'),
          ],
        ),
      ),

      // Adds padding around the grid.
      body: Padding(
        padding: const EdgeInsets.all(8.0),

        // GridView.builder dynamically builds the image grid as you scroll.
        child: GridView.builder(
          itemCount: imageUrls.length,

          // Defines how the grid is structured (2 columns, spacing between items).
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,       // number of columns (2 images per row)
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

                void _showCustomSnackbar(String message, {bool withUndo = false}) {
                  final snackBar = SnackBar(
                    content: Text(message),
                    duration: Duration(seconds: 3), // Auto-dismiss after 3 seconds
                    backgroundColor: Colors.blueGrey.shade700,
                    action: withUndo
                        ? SnackBarAction(
                      label: 'Undo',
                      textColor: Colors.yellowAccent,
                      onPressed: () {
                        // What happens when "Undo" is pressed
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Undo successful!')),
                        );
                      },
                    )
                        : null,
                  );

                  // Display the SnackBar
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }

                _showCustomSnackbar("image $imageUrls tapped");
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


class BottomNavExample extends StatefulWidget {
  @override
  _BottomNavExampleState createState() => _BottomNavExampleState();
}

class _BottomNavExampleState extends State<BottomNavExample> {
  int _selectedIndex = 0;

  // 👇 List of pages to show for each tab
  static const List<Widget> _pages = <Widget>[
    const GalleryScreen(),
    // const FullScreenImage(imageUrl: )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // 👇 Show the page based on selected index
      body: _pages[_selectedIndex],

      // 👇 BottomNavigationBar with inline onTap logic
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,       // which tab is active
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,

        // 👇 Inline callback instead of separate method
        onTap: (index) {
          setState(() {
            _selectedIndex = index;         // update selected index
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: 'Gallery',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: 'Selected',
          ),
        ],
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
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent, // no visible bar color
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),

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
