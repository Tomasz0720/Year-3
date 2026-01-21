import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'grade.dart';

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