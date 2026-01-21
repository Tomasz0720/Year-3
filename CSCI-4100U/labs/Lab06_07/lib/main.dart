// Pages (UI structure)
// The app must contain two pages:
// Page A (Add Tasks): Includes a Form for user's input: Title, Description, Priority of the task. (PARTIALLY COMPLETE)
// Page B (Todo List): Displays all tasks (completed and not completed) using a list with: (PARTIALLY COMPLETE)
// A Checkbox to toggle completion status. (INCOMPLETE)
// A Delete control to remove todo items. (PARITALLY COMPLETE)

// Navigation
// Include an App Drawer with two menu items to navigate between the pages. (INCOMPLETE)
// Tapping each drawer item must open the correct page. (INCOMPLETE but i do have a + button...)

// Database (Storage requirement) (COMPLETE- structure is there)
// Store all todo data (title, description, priority, completion status) in a database.
// The user should be able to add new tasks, update existing tasks (task completion), and delete tasks.

import 'package:flutter/material.dart';
import 'grade.dart';
import 'grades_model.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'grade.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueGrey,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: _themeMode,
      home: ListGrades(onToggleTheme: _toggleTheme),
    );
  }
}

class ListGrades extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const ListGrades({super.key, required this.onToggleTheme});

  @override
  State<ListGrades> createState() => _ListGradesState();
}

class _ListGradesState extends State<ListGrades> {
  final GradesModel _gradesModel = GradesModel();
  List<Grade> titles = [];
  int? _selectedIndex;


  void _showEditMenu(BuildContext context, int index) async{
    final result = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 100, 100, 100),
      items: [
        const PopupMenuItem(
          value: 'edit',
          child: Row(
            children: [
              Icon(Icons.edit),
              SizedBox(width: 8),
              Text('Edit Task'),
            ],
          ),
        ),
      ],
    );

  Future<void> _loadGrades() async {
    List<Grade> loadedGrades = await _gradesModel.getAllGrades();
    setState(() {
      titles = loadedGrades;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadGrades();  // ← Load grades when page opens
  }



  void _addGrade() async {
    print('Add grade button pressed');

    final Grade? result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const GradeForm()),
    );

    if (result != null) {
      await _gradesModel.insertGrade(result);
      _loadGrades();
    }
  }

  void _editGrade() async {
    if (_selectedIndex == null) {
      print('No grade selected');
      return;
    }

    print('Edit grade button pressed');
    Grade selectedTitle = titles[_selectedIndex!];

    final Grade? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GradeForm(grade: selectedTitle),
      ),
    );

    if (result != null) {
      await _gradesModel.updateGrade(result);
      _loadGrades();
    }
  }

  void _deleteGrade() async {
    if (_selectedIndex == null) {
      print('No grade selected');
      return;
    }

    print('Delete grade button pressed');
    Grade selectedGrade = titles[_selectedIndex!];

    await _gradesModel.deleteGrade(selectedGrade.id!);

    setState(() {
      _selectedIndex = null;
    });
    _loadGrades();

    print('Task deleted: ${selectedGrade.title}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        actions: [
          IconButton(
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: widget.onToggleTheme,
            tooltip: 'Toggle Theme',
          ),
        ],
      ),

      body: ListView.builder(
        itemCount: titles.length,

        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(titles[index].id.toString()),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) async{
              Grade deletedGrade = titles[index];
              await _gradesModel.deleteGrade(deletedGrade.id!);
              _loadGrades();
              print('Task deleted via swipe: ${deletedGrade.title}');
            },
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
                print('Selected index: $_selectedIndex');
              },
              onLongPress: (){
                _showEditMenu(context, index);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: _selectedIndex == index ? Colors.blueGrey[100] : null,
                ),
                child: ListTile(
                  title: Text(titles[index].title),
                  subtitle: Text('Description: ${titles[index].description} n\ Priority: ${titles[index].priority}'),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addGrade,
        child: const Icon(Icons.add),
      ),
    );
  }
}


class GradeForm extends StatefulWidget {
  final Grade? title;

  const GradeForm({super.key, this.title});

  @override
  State<GradeForm> createState() => _GradeFormState();
}

class _GradeFormState extends State<GradeForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _priorityController = TextEditingController();

  @override
  void initState(){
    super.initState();
    if(widget.title != null) {
      _titleController.text = widget.title!.title;
      _descController.text = widget.title!.description;
      _priorityController.text = widget.title!.priority;
    }
  }

  @override
  void dispose(){
    _titleController.dispose();
    _descController.dispose();
    _priorityController.dispose();
    super.dispose();
  }

  void _saveGrade() {
    String title = _titleController.text;
    String descValue = _titleController.text;
    String priorityValue = _priorityController.text;

    if (title.isEmpty || descValue.isEmpty) {
      print('Please fill in all fields');
      return;
    }

    Grade grade = Grade(
      id: widget.title?.id,
      title: title,
      description: descValue,
      priority: priorityValue,
    );

    Navigator.pop(context, grade);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title == null ? 'Add Task' : 'Edit Grade'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
              TextField(
              controller: _priorityController,
              decoration: const InputDecoration(
              labelText: 'Priority',
              border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveGrade,
        child: const Icon(Icons.save),
      ),
    );
  }
}



class Grade {
  int? id;
  String title;
  String description;
  String priority;

  Grade({
    this.id,
    required this.title,
    required this.description,
    required this.priority,
  });

  Map<String, dynamic> toMap(){
  return{
  'id': id,
  'title': title,
  'description': description,
  'priority': priority,
  };
}

    factory Grade.fromMap(Map<String, dynamic> map){
      return Grade(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      priority: map['priority'],
    );
  }
}



class GradesModel {
  static Database? _database;

  Future<Database> get database async {
      if (_database != null) return _database!;
      _database = await _initDatabase();
      return _database!;
    }

    Future<List<Grade>> getAllGrades() async {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query('grades');

      return List.generate(maps.length, (i) {
        return Grade.fromMap(maps[i]);
      });
    }

    Future<int> insertGrade(Grade grade) async {
      final db = await database;
      return await db.insert('grades', grade.toMap());
    }

    Future<int> updateGrade(Grade grade) async {
      final db = await database;
        return await db.update(
        'grades',
        grade.toMap(),
        where: 'id = ?',
        whereArgs: [grade.id],
      );
    }

    Future<int> deleteGrade(int id) async {
      final db = await database;
      return await db.delete(
      'grades',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<Database> _initDatabase() async {
      String path = join(await getDatabasesPath(), 'grades.db');

      return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
      await db.execute('''
              CREATE TABLE grades(
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                title TEXT NOT NULL,
                description TEXT NOT NULL
                priority TEXT NOT NULL
              )
            ''');
      },
    );
  }
}