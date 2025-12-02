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

  // 👇 More advanced pages: interactive, scrollable, with SnackBars
  static final List<Widget> _pages = <Widget>[

    //********************************************* Page [1]
    //*********************************************
    // HOME
    Container(
      color: Colors.blue.shade50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.home, size: 80, color: Colors.blue),
          const SizedBox(height: 20),
          const Text(
            'Welcome Home!',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Builder(
            builder: (ctx) => ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(ctx).showSnackBar(
                  const SnackBar(content: Text('You pressed Home Button!')),
                );
              },
              child: const Text('Show SnackBar'),
            ),
          ),
        ],
      ),
    ),

    //********************************************* Page [2]
    //*********************************************
    // SEARCH
    Container(
      color: Colors.green.shade50,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Search Results',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 15,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.search),
                  title: Text('Result Item #$index'),
                  subtitle: const Text('Tap to explore details'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Tapped on item #$index')),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    ),

    //********************************************* Page [3]
    //*********************************************
    // PROFILE
    Container(
      color: Colors.purple.shade50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.purple,
            child: Icon(Icons.person, size: 60, color: Colors.white),
          ),
          const SizedBox(height: 20),
          const Text(
            'John Doe',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const Text('john.doe@example.com', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Builder(
                builder: (ctx) => ElevatedButton.icon(
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit Profile'),
                  onPressed: () {
                    ScaffoldMessenger.of(ctx).showSnackBar(
                      const SnackBar(content: Text('Edit Profile tapped')),
                    );
                  },
                ),
              ),
              const SizedBox(width: 10),
              Builder(
                builder: (ctx) => OutlinedButton.icon(
                  icon: const Icon(Icons.logout),
                  label: const Text('Logout'),
                  onPressed: () {
                    ScaffoldMessenger.of(ctx).showSnackBar(
                      const SnackBar(content: Text('Logged out')),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('BottomNavigationBar Example')),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
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
