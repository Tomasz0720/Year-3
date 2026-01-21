// Model class that represents a single To-Do item.
class Todo {
  // -------------------- FIELDS --------------------

  int? id;         // Unique identifier for the To-Do item (may be null for new items)
  int? userId;     // ID of the user who owns this To-Do
  String? title;   // Title or description of the To-Do item
  bool? completed; // Indicates whether the To-Do is completed or not

  // -------------------- CONSTRUCTOR --------------------

  // constructor with optional named parameters.
  Todo({this.id, this.userId, this.title, this.completed});

  // -------------------- FACTORY CONSTRUCTOR --------------------

  // Factory constructor that creates a Todo instance from a Map (decoded JSON).
  // This is commonly used when converting JSON data from an API response
  // into a Dart object that can be used in the app.
  //{
  //   'id': 3,
  //   'userId': 1,
  //   'title': 'Finish Flutter assignment',
  //   'completed': false,
  // }
  factory Todo.fromMap(Map map) {
    return Todo(
      id: map['id'],             // Extracts the 'id' field from the map
      userId: map['userId'],     // Extracts the 'userId' field
      title: map['title'],       // Extracts the 'title' field
      completed: map['completed'], // Extracts the 'completed' field (true/false)
    );
  }

  // -------------------- DEBUG / PRINT HELPER --------------------

  // Overrides the default toString() method to make debugging easier.
  // When printed, it shows the Todo details in a readable format.
  @override
  String toString() {
    return 'Todo($id, $userId, $title, $completed)';
  }
}
