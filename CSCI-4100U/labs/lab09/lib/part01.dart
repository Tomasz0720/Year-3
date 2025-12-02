import 'package:flutter/material.dart';

// Entry point of the Flutter application.
void main() => runApp(const Part01());

class Part01 extends StatelessWidget {
  const Part01({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Part 01 - Display Network Image with States',
      home: Scaffold(
        appBar: AppBar(
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Part 01'),
              Text('Display Network Image with States'),
            ],
          ),
        ),
        body: const Center(
          child: ImageExample(),
        ),
      ),
    );
  }
}

class ImageExample extends StatefulWidget {
  const ImageExample({super.key});

  @override
  State<ImageExample> createState() => _ImageExampleState();
}

class _ImageExampleState extends State<ImageExample> {
  BoxFit currentFit = BoxFit.cover;
  bool _forceError = false;

  @override
  Widget build(BuildContext context) {
    // Choose a valid or intentionally invalid URL based on _forceError
    final imageUrl = _forceError
        ? 'https://happyhappyfuntime!@#.com/invalid-image.jpg'
        : 'https://tomaszpuzio.ca/images/banner.png';

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(
          imageUrl,
          width: 300,
          height: 200,
          fit: currentFit,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const SizedBox(
              width: 300,
              height: 200,
              child: Center(child: CircularProgressIndicator()),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 300,
              height: 200,
              color: Colors.grey[300],
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 48, color: Colors.red),
                  SizedBox(height: 8),
                  Text(
                    '⚠️ Failed to load image',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  currentFit = BoxFit.cover;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    currentFit == BoxFit.cover ? Colors.grey : Colors.grey,
              ),
              child: const Text('Cover'),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  currentFit = BoxFit.contain;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    currentFit == BoxFit.contain ? Colors.grey : Colors.grey,
              ),
              child: const Text('Contain'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Toggle button to force error / restore image
        ElevatedButton(
          onPressed: () {
            setState(() {
              _forceError = !_forceError;
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: _forceError ? Colors.grey : Colors.grey,
          ),
          child: Text(_forceError ? 'Load URL' : 'Error'),
        ),
      ],
    );
  }
}