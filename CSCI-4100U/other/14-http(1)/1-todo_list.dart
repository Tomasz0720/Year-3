// Import Flutter's core material design package for UI components.
import 'package:flutter/material.dart';

// Import JSON utilities for encoding and decoding data.
import 'dart:convert';

// Import the HTTP package for making network requests.
import 'package:http/http.dart' as http;

// Import a custom class definition for Todo items (user-defined model).
import '1-todo.dart';

// ------------------------- MAIN WIDGET -------------------------

// The main StatefulWidget that represents the To-Do list screen.
class TodoList extends StatefulWidget {
  // Optional title for the page.
  final String? title;

  // Constructor — passes the key and optional title to the parent.
  TodoList({Key? key, this.title}) : super(key: key);

  // Creates the mutable state object for this widget.
  @override
  _TodoListState createState() => _TodoListState();
}

// ------------------------- STATE CLASS -------------------------

// Holds the actual data and logic for the TodoList widget.
class _TodoListState extends State<TodoList> {
  // List to store the ToDo items (initially empty).
  List<Todo> _todos = [];

  // Runs once when the widget is first inserted into the widget tree.
  @override
  void initState() {
    super.initState();
    loadTodos(); // Fetch initial data from the API.
  }

  // ------------------------- LOAD TODOS -------------------------

  // Fetches the list of todos from the remote API.
  Future<void> loadTodos() async {

    // Sends an asynchronous HTTP GET request to the given URL.
    // 'await' pauses the function until the server responds.
    // 'http.get()' comes from the 'http' package and performs the network request.
    // 'Uri.parse()' converts the string URL into a proper Uri object required by http.get().
    // The result (server's reply) is stored in the variable 'response'.
    var response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));

    // If the response is successful (HTTP 200 OK)...
    if (response.statusCode == 200) {
      setState(() {
        _todos = []; // Reset the list.

        // Converts the JSON text (in response.body) into a Dart object.
        // response.body is a string that contains raw JSON data from the server.
        // jsonDecode() parses that string and returns a Dart object —
        // in this case, a List of dynamic Maps, because the JSON represents an array of todo items.
        // Each element of this list is a Map<String, dynamic> corresponding to one todo entry.
        ////{
        //   //   'id': 3,
        //   //   'userId': 1,
        //   //   'title': 'Finish Flutter assignment',
        //   //   'completed': false,
        //   // }
        List todoItems = jsonDecode(response.body);

        // Convert each map from the list into a Todo object.
        for (var item in todoItems) {
          _todos.add(Todo.fromMap(item));
        }
      });
    }
  }

  // ------------------------- ADD TODO -------------------------

  // Sends a POST request to add a new ToDo item to the API.
  Future<void> addTodo(String title) async {
    // Sends an asynchronous HTTP POST request to create a new "todo" item on the server.
    var response = await http.post(
      // Converts the string URL into a Uri object (required by http.post).
      Uri.parse('https://jsonplaceholder.typicode.com/todos'),

      // Sets request headers — here specifying that the body data is in JSON format.
      headers: {"Content-Type": "application/json"},

      // Converts a Dart Map into a JSON string to send as the request body.
      // This body contains the new todo's title, completion status, and user ID.
      body: jsonEncode({
        "title": title,       // The title of the new todo (passed into the function).
        "completed": false,   // Marks the todo as incomplete by default.
        "userId": 1           // Assigns this todo to user with ID 1.
      }),
    );

    // ------------------- OTHER COMMON HEADERS -------------------
    // "Accept": "application/json",       // Ask the server to respond in JSON
    // "Authorization": "Bearer <token>",  // Used for authenticated API calls (JWT, OAuth)
    // "User-Agent": "FlutterApp/1.0",     // Identifies the app making the request
    // "Cache-Control": "no-cache",        // Prevents cached responses
    // "Accept-Language": "en-US",         // Indicates preferred response language
    // "Connection": "keep-alive",         // Keeps the connection open for multiple requests
    // "Referer": "https://yourapp.com",   // Identifies where the request originated
    // "X-API-Key": "<your_api_key>",      // Custom API key header for some services



    // If creation is successful (HTTP 201 Created)...
    if (response.statusCode == 201) {
      setState(() {
        // Decode the new todo and add it to the local list.
        _todos.add(Todo.fromMap(jsonDecode(response.body)));
      });
    }
  }

  // ------------------------- UPDATE TODO -------------------------

  // Updates the completion status of a ToDo item on the server.
  Future<void> updateTodoStatus(int id, bool newStatus) async {
    var response = await http.patch(
      Uri.parse('https://jsonplaceholder.typicode.com/todos/$id'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"completed": newStatus}),
    );

    // If update was successful (HTTP 200 OK)...
    if (response.statusCode == 200) {
      setState(() {
        // Find and update the todo locally.
        var todo = _todos.firstWhere((todo) => todo.id == id);
        todo.completed = newStatus;
      });
    }
  }

  // ------------------------- UI BUILD -------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? 'Todo List'),
        actions: <Widget>[
          // Add button in the AppBar.
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              // Adds a new todo item when pressed.
              await addTodo('New ToDo Item');
            },
          ),

          // Delete button in the AppBar.
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // Temporary list to store todos that are not completed.
              List<Todo> newTodos = [];

              for (var todo in _todos) {
                if (!todo.completed!) {
                  // Keep unfinished todos.
                  newTodos.add(todo);
                } else {
                  // Delete completed todos from the server.
                  http.delete(
                    Uri.parse('https://jsonplaceholder.typicode.com/todos/${todo.id}'),
                  );
                }
              }

              // Update the state with filtered list.
              setState(() {
                _todos = newTodos;
              });
            },
          ),
        ],
      ),

      // The body shows the list of todos.
      body: _createTodosList(),
    );
  }

  // ------------------------- LIST BUILDER -------------------------

  // Builds the widget that displays the list of ToDo items.
  Widget _createTodosList() {
    // If the list hasn’t loaded yet, show a loading spinner.
    if (_todos.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    // Build a scrollable list dynamically.
    return ListView.builder(
      itemCount: _todos.length,
      itemBuilder: (BuildContext context, int index) {
        final todo = _todos[index];
        return ListTile(
          title: Text(todo.title ?? 'Untitled'),
          subtitle: Text('User ID: ${todo.userId ?? '-'}'),
          leading: Checkbox(
            value: todo.completed ?? false,
            onChanged: (bool? value) {
              // Update the completion status both locally and remotely.
              setState(() {
                todo.completed = value;
                updateTodoStatus(todo.id!, value!);
              });
            },
          ),
        );
      },
    );
  }
}
