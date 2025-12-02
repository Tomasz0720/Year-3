import 'package:flutter/material.dart';
import 'practice-DrawerWidget.dart';

void main() => runApp(MyApp());

// ============================
// MAIN APP
// ============================
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Drawer Demo',
      home: HomePage(),
    );
  }
}

// ============================
// MAIN PAGE
// ============================
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedPage = "Home Page"; // text that updates when menu tapped

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simple Drawer Example')),

      // 👇 Drawer widget with inline callback
      drawer: AppDrawer(
        onMenuItemSelected: (page) {
          Navigator.pop(context); // close the drawer
          setState(() {
            selectedPage = page; // update displayed text
          });
        },
      ),

      // 👇 Display selected page
      body: Center(
        child: Text(
          'You selected: $selectedPage',
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}