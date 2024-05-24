import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: (db, oldVersion, newVersion) async {
        // Handle database schema upgrades here if necessary
        if (oldVersion < newVersion) {
          // Add migration logic to update schema from oldVersion to newVersion
          print('Database schema upgraded from $oldVersion to $newVersion');
        }
      },
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE courses (
        id INTEGER PRIMARY KEY,
        title TEXT,
        icon TEXT,
      )
    ''');

    await db.execute('''
          CREATE TABLE assignments (
            id INTEGER PRIMARY KEY,
            title TEXT,
            due_date DATE,
            course_id INTEGER,
            FOREIGN KEY (course_id) REFERENCES courses(id)
          )
        ''');

    await db.execute('''
      INSERT INTO courses (title, icon, dueDate)
      VALUES ('Flutter', 'flutter')
    ''');

    await db.execute('''
      INSERT INTO courses (title, icon, dueDate)
      VALUES ('Dart', 'dart')
    ''');

    await db.execute('''
        INSERT INTO assignments (title, due_date, course_id)
        VALUES ('Assignment 1', '2020-01-01', 1)
      ''');

    await db.execute('''
        INSERT INTO assignments (title, due_date, course_id)
        VALUES ('Assignment 2', '2077-01-01', 1)
      ''');
  }

  Future<List<Map<String, dynamic>>> getCourses() async {
    Database db = await database;
    return await db.query('courses');
  }

  Future<int> insertCourse(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('courses', row);
  }

  Future<int> updateCourse(Map<String, dynamic> row) async {
    Database db = await database;
    int id = row['id'];
    return await db.update('courses', row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteCourse(int id) async {
    Database db = await database;
    return await db.delete('courses', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getAssignmentsByCourseId(
      int courseId) async {
    Database db = await database;
    return await db.query(
      'assignments',
      where: 'course_id = ?',
      whereArgs: [courseId],
    );
  }

  Future<List<Map<String, dynamic>>> getAssignments() async {
    Database db = await database;
    return await db.query(
      'assignments',
    );
  }

  Future<int> insertAssignment(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('assignments', row);
  }

  Future<int> updateAssignment(Map<String, dynamic> row) async {
    Database db = await database;
    int id = row['id'];
    return await db
        .update('assignments', row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteAssignment(int id) async {
    Database db = await database;
    return await db.delete('assignments', where: 'id = ?', whereArgs: [id]);
  }
}
