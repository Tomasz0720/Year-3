import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//[A] ...checkout the format first
//https://jsonplaceholder.typicode.com/users

// ---------------------- MODEL CLASS ----------------------
class User {
  final int id;
  final String name;
  final String email;
  final String phone;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  //[B]
  factory User.fromJson(Map <String, dynamic> json) {
    return User(
          id: json['id'],
          name: json['name'],
          email: json['email'],
          phone: json['phone'],
    );
  }
}

// ---------------------- MAIN APP ----------------------
void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: UserListScreen(),
  ));
}

// ---------------------- USER LIST SCREEN ----------------------
class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<User> _users = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  // ---------------------- LOAD USERS ----------------------
  Future<void> loadUsers() async {
    setState(() => _isLoading = true);

    //[C] getting data - which method of http?
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      //[C.1] decode or encode?
      final List data = jsonDecode(response.body);
      setState(() {
        //I'd say the next line is the "most complicated" part of this program **************************************************
        //if you don't understand this part - you didn't get how the previous code work!!!!!*************************************
        _users = data.map((e) => User.fromJson(e as Map<String, dynamic>)).toList(); //[D] one line of code using .map 'function' => A+ (show off your programming skills) // -- or use a 'for' loop - 100% fine
        _isLoading = false;
      });
    } else {
      setState(() => _isLoading = false);
    }
  }

  // ---------------------- DELETE USER ----------------------
  Future<void> deleteUser(int id) async {
    // Remove locally first (optimistic update)
    setState(() {
      _users.removeWhere((user) => user.id == id); //[E] remove it from the list (this is about UI) -based on their id
    });

    //  DELETE request
    // [F] which http method?
    final response = await http.delete(
      Uri.parse('https://jsonplaceholder.typicode.com/users/$id'), //[G] fix the string - what is missing
    );

    if (response.statusCode != 200) {
      // If failed, you could restore the user or show a message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete user $id')),
      );
    }
  }

  // ---------------------- BUILD UI ----------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: loadUsers, //... [G] - load the data
            tooltip: 'Reload Users',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _users.isEmpty
          ? const Center(child: Text('No users found'))
          : ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          //[H] What is "user" in the next line? map? object?
          final user = _users[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              leading: CircleAvatar(child: Text(user.id.toString())),
              title: Text(user.name),
              subtitle: Text('${user.email}\n${user.phone}'),
              isThreeLine: true,
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.redAccent),
                onPressed: () => deleteUser(user.id),
              ),
            ),
          );
        },
      ),
    );
  }
}
