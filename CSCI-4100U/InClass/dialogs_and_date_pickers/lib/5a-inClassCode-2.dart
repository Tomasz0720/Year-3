//use 5a-4 as template
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true, // still using M3, but we override button shape
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  4), // 👈 small corner radius = rectangular
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
      home: DialogPracticeScreen(),
    );
  }
}

class DialogPracticeScreen extends StatefulWidget {
  @override
  State<DialogPracticeScreen> createState() => _DialogPracticeScreenState();
}

class _DialogPracticeScreenState extends State<DialogPracticeScreen> {
  String? _selected;

  void _showSimpleDialog() {
    showDialog<String>( //[A] command to show the dialog
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return SimpleDialogBox(); //[B] object of our custom dialogBox;
      },
    ).then((value) {
      if (value != null) {
        setState(() =>
        _selected = value); //[C] update UI by updating the value of _selected
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Dialog Practice')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: _showSimpleDialog,
              child: const Text('Show Dialog'),
            ),
            const SizedBox(height: 20),
            Text(
              _selected == null
                  ? 'No selection yet.'
                  : 'You selected: $_selected',
              //[D] value selected in dialog box if it's not null
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

// ==============================
// Separate Custom Dialog Class
// ==============================
class SimpleDialogBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog( // [E] Custom dialog
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Make a selection...'),
              //[F] generate the title - text/textstyle,
              const SizedBox(height: 8),

              const Text('Please select an option below.'),
              //[G] description - text/textstyle

              const SizedBox(height: 16),
              //[H] vertical space - 16

              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OutlinedButton(
                        onPressed: () => Navigator.pop(context, 'A'),
                        child: const Text('A'),
                      ),
                      OutlinedButton(
                        onPressed: () => Navigator.pop(context, 'B'),
                        child: const Text('B'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OutlinedButton(
                        onPressed: () => Navigator.pop(context, 'C'),
                        child: const Text('C'),
                      ),
                      OutlinedButton(
                        onPressed: () => Navigator.pop(context, 'D'),
                        child: const Text('D'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        )
    );
  }
}
