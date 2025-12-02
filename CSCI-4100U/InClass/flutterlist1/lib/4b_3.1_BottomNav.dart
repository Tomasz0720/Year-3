import 'package:flutter/material.dart';

void main() => runApp(MyApp());

// ============================
// MAIN APP
// ============================
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bottom Navigation Demo',
      home: BottomNavExample(),
    );
  }
}

// ============================
// MAIN PAGE WITH INLINE onTap
// ============================
class BottomNavExample extends StatefulWidget {
  @override
  _BottomNavExampleState createState() => _BottomNavExampleState();
}

class _BottomNavExampleState extends State<BottomNavExample> {
  int _selectedIndex = 0;

  // 👇 List of pages to show for each tab
  static const List<Widget> _pages = <Widget>[
    Center(child: Text('Home Page', style: TextStyle(fontSize: 24))),
    Center(child: Text('Search Page', style: TextStyle(fontSize: 24))),
    Center(child: Text('Profile Page', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('BottomNavigationBar Example')),

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
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
