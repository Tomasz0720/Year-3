import 'package:flutter/material.dart';

// AppDrawer widget is a custom navigation drawer widget.
// It takes a function callback 'onTap' as a parameter that handles what happens when a menu item is clicked.
class AppDrawer extends StatelessWidget {
  final Function(String) onTapMyVersion; // Callback function that takes a String as an argument.

  // Constructor to initialize the onTap function. It requires the function to be provided when AppDrawer is created.
  AppDrawer({required this.onTapMyVersion});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Drawer widget provides a slide-in panel from the side of the screen.
      child: ListView(
        // Removes default padding from the ListView to make it full-screen inside the Drawer.
        padding: EdgeInsets.zero,
        // A list of widgets (children) inside the drawer.
        children: <Widget>[
          // DrawerHeader is a special header at the top of the drawer.
          DrawerHeader(
            // Display the title text inside the DrawerHeader
            child: Text(
              'Drawer Menu',
              style: TextStyle(fontSize: 36), // Large font size for the title
            ),
            // Sets the background color for the DrawerHeader
            decoration: BoxDecoration(
              color: Colors.blue, // Blue background color for the header
            ),
          ),
          // A ListTile widget represents an item inside the drawer menu.
          ListTile(
            // Text label for this menu item
            title: Text('Form Page'),
            // What happens when this menu item is tapped
            onTap: () {
              // Calls the onTap callback function and passes 'Form Page' as an argument.
              // This helps in navigating to the 'Form Page'.
              onTapMyVersion('Form Page');
            },
          ),
          ListTile(
            // Text label for the second menu item
            title: Text('Display Page'),
            // What happens when this menu item is tapped
            onTap: () {
              // Calls the onTap callback function and passes 'Display Page' as an argument.
              // This helps in navigating to the 'Display Page'.
              onTapMyVersion('Display Page');
            },
          ),
        ],
      ),
    );
  }
}
