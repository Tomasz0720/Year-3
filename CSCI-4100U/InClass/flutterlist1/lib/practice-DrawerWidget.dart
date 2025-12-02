import 'package:flutter/material.dart';
// ============================
// SEPARATE DRAWER WIDGET
// ============================
class AppDrawer extends StatelessWidget {
  // 👇 User-defined callback function
  final void Function(String) onMenuItemSelected;

  const AppDrawer({required this.onMenuItemSelected, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Menu',
              style: TextStyle(fontSize: 28, color: Colors.white),
            ),
          ),
          ListTile(
            title: Text('Form Page'),
            onTap: () {
              onMenuItemSelected('Form Page');
            },
          ),
          ListTile(
            title: Text('Display Page'),
            onTap: () {
              onMenuItemSelected('Display Page');
            },
          ),
        ],
      ),
    );
  }
}