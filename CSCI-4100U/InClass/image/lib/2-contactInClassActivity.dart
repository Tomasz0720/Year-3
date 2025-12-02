import 'package:flutter/material.dart';

void main() => runApp(const ContactListApp());

class ContactListApp extends StatelessWidget {
  const ContactListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact List Example',
      home: Scaffold(
        appBar: AppBar(title: const Text('My Contacts')),
        body: const ContactList(),
      ),
    );
  }
}

class ContactList extends StatelessWidget {
  const ContactList({super.key});

  @override
  Widget build(BuildContext context) {
    // Simple list of contacts (name + phone number)
    final contacts = [
      {'name': 'Alice Johnson', 'phone': '123-456-7890'},
      {'name': 'Bob Smith', 'phone': '234-567-8901'},
      {'name': 'Charlie Davis', 'phone': '345-678-9012'},
    ];

    return ListView.builder(
      // your code
      //'assets/images/green.png' or use any other image
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: ClipOval(
            child: Image.asset(
              'assets/images/green.png',
              width: 60,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(contacts[index]['name']!),
          subtitle: Text(contacts[index]['phone']!),
          onTap: () {
            final snackBar = SnackBar(
              content: Text('${contacts[index]['name']} - ${contacts[index]['phone']}'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
        );
      },

    );
  }
}

//5-ListView3 -> listview
//6a-1 -> snackbar